#!/bin/bash
set -e

WP_PATH="/var/www/html"
cd "$WP_PATH"

# Read password from secrets
DB_PASSWORD=$(cat /run/secrets/db_password)
WP_SUPERUSER_PASSWORD=$(cat /run/secrets/wp_superuser_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

# Wait for MariaDB port to open
echo "Waiting for MariaDB.."
until nc -z mariadb 3306; do
    sleep 2
done

# Wait for the database and user to be ready
MAX_TRIES=30
COUNT=0
until mariadb -h mariadb -u "${WORDPRESS_DB_USER}" -p"${DB_PASSWORD}" "${WORDPRESS_DB_NAME}" -e ";" 2>/dev/null; do
    COUNT=$((COUNT + 1))
    if [ $COUNT -ge $MAX_TRIES ]; then
        echo "ERROR: Could not connect to database after $MAX_TRIES attempts"
        exit 1
    fi
    echo "Database not ready yet (attempt $COUNT/$MAX_TRIES).."
    sleep 2
done
echo "MariaDB is ready"

# The volume persists if wp-config.php exists
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    echo "Installing WP-CLI.."
    curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x /usr/local/bin/wp

    echo "Downloading WordPress core.."
    wp core download --path="$WP_PATH" --allow-root

    echo "Creating wp-config.php.."
    wp config create \
        --path="$WP_PATH" \
        --dbname="$WORDPRESS_DB_NAME" \
        --dbuser="$WORDPRESS_DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost=mariadb \
        --allow-root

    echo "Installing WordPress.."
    wp core install \
        --path="$WP_PATH" \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_SUPERUSER_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root
    
    echo "Creating subscriber user.."
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --path="$WP_PATH" \
        --user_pass="$WP_USER_PASSWORD" \
        --role=subscriber \
        --allow-root

    echo "WordPress setup complete."
else
    echo "WordPress already initialized, skipping setup."
fi

# Set secure permissions
find "$WP_PATH" -type d -exec chmod 750 {} \;
find "$WP_PATH" -type f -exec chmod 640 {} \;
chown -R www-data:www-data "$WP_PATH"

echo "Starting PHP-FPM.."
# PHP-FPM needs a dir for its socket/PID file
mkdir -p /run/php

exec php-fpm8.2 -F
