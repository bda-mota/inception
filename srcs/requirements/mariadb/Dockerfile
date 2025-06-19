FROM debian:bullseye

ARG WORDPRESS_DATABASE
ARG WORDPRESS_USER
ARG WORDPRESS_PASSWORD

RUN apt update -y && apt upgrade -y && apt install mariadb-server -y

# By default MariaDB is bound to localhost, it does not allow remote connections
# This setting allows remote connections from any host ( in our case, other containers )
RUN echo "[mysqld] \n\
skip-networking=0 \n\
skip-bind-address" >> /etc/mysql/my.cnf

# Start the mariadb service and create a database and user for wordpress
RUN service mariadb start && \
	mariadb -u root -e \
	"CREATE DATABASE IF NOT EXISTS wordpress_db; \
	CREATE USER 'wuser'@'%' identified by 'wpass'; \
	GRANT ALL ON wordpress_db.* TO 'wuser'@'%' IDENTIFIED BY 'wpass'; \
	FLUSH PRIVILEGES;" && \
	mariadb -u root $WORDPRESS_DATABASE < /tmp/dump.sql && \
	service mariadb stop

# Start the mariadb service when the container is run
CMD ["mysqld_safe"]