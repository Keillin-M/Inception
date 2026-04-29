#!/bin/bash
set -e

# Ensure SSL directory exists
mkdir -p /etc/nginx/ssl

# Default domain if not provided
: "${DOMAIN_NAME:=localhost}"

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
nginx -t || exit 1

# Start nginx in foreground 
echo "Starting Nginx.."
exec nginx -g "daemon off;"
