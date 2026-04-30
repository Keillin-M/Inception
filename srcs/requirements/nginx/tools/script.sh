#!/bin/bash
set -e

envsubst '${DOMAIN_NAME}' \
    < /etc/nginx/nginx.conf.template \
    > /etc/nginx/nginx.conf

# Ensure SSL directory exists
mkdir -p /etc/nginx/ssl

# Generate certificate if it doesn't exist
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    echo "Generating self-signed SSL certificate for ${DOMAIN_NAME}.."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=US/ST=State/L=City/O=Organization/CN=${DOMAIN_NAME}"
    chmod 600 /etc/nginx/ssl/nginx.key
    chmod 644 /etc/nginx/ssl/nginx.crt
fi

# Test nginx configuration before starting
echo "Testing nginx configuration.."
nginx -t

# Start nginx in foreground so it becomes PID 1
echo "Starting Nginx.."
exec nginx -g "daemon off;"
