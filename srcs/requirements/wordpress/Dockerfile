
FROM debian:bookworm

RUN apt-get update && apt-get install -y \
  php7.4-fpm \
  php7.4-mysql \
  php7.4-curl \
  php7.4-gd \
  php7.4-intl \
  php7.4-mbstring \
  php7.4-soap \
  php7.4-xml \
  php7.4-zip \
  wget \
  curl \
  netcat-openbsd \
  mariadb-client \
  && ln -s /usr/sbin/php-fpm7.4 /usr/local/bin/php-fpm \
  && rm -rf /var/lib/apt/lists/*

# Create WordPress directory
WORKDIR /var/www/html

# Copy PHP-FPM configuration
COPY www.conf /etc/php/7.4/fpm/pool.d/

# Copy and set permissions for setup script
COPY tools/script.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/script.sh

EXPOSE 9000

ENTRYPOINT ["/usr/local/bin/script.sh"]
