FROM debian:bookworm

# Install nginx and openssl
RUN apt-get update && apt-get install -y --no-install-recommends \
    nginx \
    openssl \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY conf/nginx.conf.template /etc/nginx/nginx.conf.template
COPY tools/script.sh /usr/local/bin/script.sh

# Set permissions
RUN chmod +x /usr/local/bin/script.sh

EXPOSE ${NGINX_PORT}

ENTRYPOINT ["/usr/local/bin/script.sh"]
