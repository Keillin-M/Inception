#!/bin/bash

# Read secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Init data if does not exist
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB.."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "MariaDB initialized!"

    # Start temporarily to run setup SQL 
    mysqld --skip-networking &
    TEMP_PID=$!
    sleep 3

    mariadb -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER 'wp_user'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EOF
    kill $TEMP_PID 2>/dev/null || true
    sleep 2
else
    echo "MariaDB already initialized, ensuring users exist..."
    # Start MariaDB temporarily to configure users
    mysqld &
    TEMP_PID=$!
    sleep 3
    
    mariadb -u root -p"${DB_ROOT_PASSWORD}" <<EOF 2>/dev/null || true
CREATE DATABASE IF NOT EXISTS wordpress_db;
DROP USER IF EXISTS 'wp_user'@'%';
CREATE USER 'wp_user'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EOF
    kill $TEMP_PID 2>/dev/null || true
    sleep 2
fi

# Start MariaDB
exec mysqld
