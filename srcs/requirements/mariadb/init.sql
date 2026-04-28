
CREATE DATABASE IF NOT EXISTS wordpress_db;
DB_PASSWORD=$(cat /run/secrets/db_password)
mysql -e "CREATE USER 'wp_user'@'%' IDENTIFIED BY '${DB_PASSWORD}';"
