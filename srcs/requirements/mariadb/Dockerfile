FROM debian:bookworm

# Install MariaDB
RUN apt update && apt upgrade && apt install -y \
    mariadb-server

# Copy config files
COPY 50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY init.sql /etc/mysql/init.sql
COPY tools/script.sh /usr/local/bin/script.sh

# Create dir and set permissions
RUN mkdir /run/mysqld && \
    chmod +x /usr/local/bin/script.sh

CMD ["/usr/local/bin/script.sh"]

