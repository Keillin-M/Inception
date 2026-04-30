FROM debian:bookworm

# - mariadb-server: the database engine itself.
# - gettext-base:   provides `envsubst`, used by tools/script.sh to render
#                   init.sql with values from secrets and .env at startup.
# We use `apt-get` (not `apt`) because apt has no stable CLI for scripts,
# `--no-install-recommends` keeps the image slim, and we drop the apt
# lists at the end so they don't bloat the layer.
RUN apt-get update && apt-get install -y --no-install-recommends \
    mariadb-server \
    gettext-base \
    && rm -rf /var/lib/apt/lists/*

# Custom server config (datadir, bind-address, etc.)
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# SQL applied at startup, with ${...} placeholders substituted from env vars
COPY init.sql /etc/mysql/init.sql

# Entrypoint: initializes the DB on first run, then exec's mysqld as PID 1
COPY tools/script.sh /usr/local/bin/script.sh

# /run/mysqld holds mysqld's unix socket and pid file
RUN mkdir -p /run/mysqld && chmod +x /usr/local/bin/script.sh

EXPOSE 3306

ENTRYPOINT ["/usr/local/bin/script.sh"]
