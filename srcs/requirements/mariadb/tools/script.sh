#!/bin/bash

# Read secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

# Init data if does not exist
if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB.."
	mysql_install_db --user=mysql --datadir=/var/lib/mysql
    echo "MariaDB initialized!"
fi

mysqld
