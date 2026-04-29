#!/bin/bash

# Read secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Init data if does not exist
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB.."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "MariaDB initialized!"

    # Start a temporarily to run setup SQL 
    mysqld --skip-networking &
    sleep 3

    mysql -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS wordpress_db;
CREATE USER IF NOT EXISTS 'wp_user'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wp_user'@'%';
FLUSH PRIVILEGES;
EOF
    kill $(cat /run/mysqld/mysql.pid)
    sleep 2
fi

# Start MariaDB
exec mysqld
