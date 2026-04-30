#!/bin/bash
set -e

# Read secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Export - child process can access envsubst
# MYSQL_USER and MYSQL_DATABASE come from the .env file via docker-compose
export DB_ROOT_PASSWORD DB_PASSWORD MYSQL_USER MYSQL_DATABASE

# Init data if does not exist
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB.."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null
    AUTH=()  # First boot: root has no password yet

else
    echo "MariaDB already initialized, keeping credentials in sync.."
    AUTH=(-p"${DB_ROOT_PASSWORD}")   # Subsequent boots: authenticate as root
fi

# Start temporary mysql
mysqld --skip-networking &      # Listens only on local unix socket
TEMP_PID=$!

echo "Waiting for temporary MariaDB to accept connections.."
until mariadb -u root "${AUTH[@]}" -e ";" 2>/dev/null; do
    sleep 1
done

# Replace env vars into init.sql - pipe to server
echo "Applying init.sql.."
envsubst '${DB_ROOT_PASSWORD} ${DB_PASSWORD} ${MYSQL_USER} ${MYSQL_DATABASE}' \
    < /etc/mysql/init.sql \
    | mariadb -u root "${AUTH[@]}"

echo "Shutting down temporary MariaDB.."
mariadb -u root -p"${DB_ROOT_PASSWORD}" -e "SHUTDOWN;"
wait "$TEMP_PID"

echo "Starting MariaDB.."
exec mysqld
