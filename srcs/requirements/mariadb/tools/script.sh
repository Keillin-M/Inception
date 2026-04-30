#!/bin/bash
set -e

# Read passwords from Docker secrets — never bake credentials into the image
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_PASSWORD=$(cat /run/secrets/db_password)

# Export so the envsubst child process can see them.
# MYSQL_USER and MYSQL_DATABASE come from the .env file via docker-compose
# and are already in this process's environment.
export DB_ROOT_PASSWORD DB_PASSWORD MYSQL_USER MYSQL_DATABASE

# /var/lib/mysql/mysql exists once the system tables have been created, so we
# use it as our "is initialized" marker.
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory.."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql >/dev/null
    AUTH=()                          # First boot: root has no password yet
else
    echo "Data dir found — re-applying init.sql to keep credentials in sync.."
    AUTH=(-p"${DB_ROOT_PASSWORD}")   # Subsequent boots: authenticate as root
fi

# Start a temporary mysqld with --skip-networking so:
#   1) the daemon listens only on the local unix socket (no external clients)
#   2) we can connect as root and apply init.sql without a race
# This is a short-lived background process — we shut it down cleanly below
# and then exec the real, foreground mysqld.
mysqld --skip-networking &
TEMP_PID=$!

# Poll the local socket until mysqld accepts connections (more reliable
# than a fixed sleep — install times vary across machines).
echo "Waiting for temporary MariaDB to accept connections.."
until mariadb -u root "${AUTH[@]}" -e ";" 2>/dev/null; do
    sleep 1
done

# Substitute env vars (root password, app user, app password, db name) into
# init.sql and pipe the result to the server. The whitelist (first arg) makes
# envsubst touch ONLY those four placeholders, so any other $-something in
# the SQL would be left alone.
echo "Applying init.sql.."
envsubst '${DB_ROOT_PASSWORD} ${DB_PASSWORD} ${MYSQL_USER} ${MYSQL_DATABASE}' \
    < /etc/mysql/init.sql \
    | mariadb -u root "${AUTH[@]}"

# Graceful shutdown of the temp server. SHUTDOWN tells mysqld to flush its
# InnoDB buffers and exit cleanly — far safer than `kill`, which can corrupt
# data files. `wait` blocks until the background process actually exits, so
# the data lock is released before we exec the real mysqld.
echo "Shutting down temporary MariaDB.."
mariadb -u root -p"${DB_ROOT_PASSWORD}" -e "SHUTDOWN;"
wait "$TEMP_PID"

# Replace this shell with mysqld so it becomes PID 1 and receives signals
# directly — that way `docker stop` reaches mysqld instead of bash.
echo "Starting MariaDB.."
exec mysqld
