FROM debian:bookworm

# Install nginx and openssl
RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Copy configuration files
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/script.sh /usr/local/bin/script.sh

# Set permissions
RUN chmod +x /usr/local/bin/*.sh

EXPOSE 443

ENTRYPOINT ["/usr/local/bin/script.sh"]
