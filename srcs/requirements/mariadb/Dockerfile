FROM debian:bookworm

# Install MariaDB
RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-server \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Copy config files
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
# SQL applied at startup
COPY init.sql /etc/mysql/init.sql
# Entrypoint: init DB on first run
COPY tools/script.sh /usr/local/bin/script.sh

# Create dir and set permissions
RUN mkdir -p /run/mysqld && \
    chmod +x /usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/script.sh"]
