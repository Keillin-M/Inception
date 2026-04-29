#!/bin/bash
set -e

# Render nginx.conf from its template. The first argument to envsubst is a
# whitelist — only ${DOMAIN_NAME} is substituted, so nginx's own variables
# ($uri, $args, $document_root, ...) are left untouched.
envsubst '${DOMAIN_NAME}' \
    < /etc/nginx/nginx.conf.template \
    > /etc/nginx/nginx.conf

# Generate a self-signed TLS certificate on first run only (subject allows
# self-signed; CN must match the domain so curl/openssl validates the host).
mkdir -p /etc/nginx/ssl
if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    echo "Generating self-signed SSL certificate for ${DOMAIN_NAME}.."
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=US/ST=State/L=City/O=Organization/CN=${DOMAIN_NAME}"
    chmod 600 /etc/nginx/ssl/nginx.key
    chmod 644 /etc/nginx/ssl/nginx.crt
fi

# Sanity-check the rendered config before launching nginx
echo "Testing nginx configuration.."
nginx -t

# Replace this shell with nginx in the foreground so it becomes PID 1
echo "Starting Nginx.."
exec nginx -g "daemon off;"
