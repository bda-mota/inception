FROM debian:oldstable

# Environment variables to be passed at runtime via docker-compose
ENV ADMIN_NAME=${ADMIN_NAME}
ENV ADMIN_PASSWORD=${ADMIN_PASSWORD}
ENV DATABASE_HOST=${DATABASE_HOST}

# Set the working directory to /var/www/html (Where WordPress will be installed)
WORKDIR /var/www/html/

# Install PHP, MySQL support, MariaDB client, wget, curl and cleanup
RUN apt update -y && apt upgrade -y && apt install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    wget \
    curl && \
    rm -rf /var/lib/apt/lists/*

# Install WP-CLI to manage WordPress via command line
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Replace the default PHP-FPM listen location (which is a Unix socket) with port 9000
RUN sed -i "s|^listen =.*|listen = 0.0.0.0:9000|" /etc/php/7.4/fpm/pool.d/www.conf

# Create the directory where PHP-FPM will store the PID/socket file (just in case)
RUN mkdir -p /run/php

# Download and extract WordPress
RUN wget https://wordpress.org/latest.tar.gz -O latest.tar.gz && \
    tar -xvzf latest.tar.gz && \
    mv wordpress/* /var/www/html/ && \
    rm -rf wordpress latest.tar.gz

# Copy the setup script that will be executed when the container starts
COPY /conf/run.sh /tmp/wp_setup.sh

# Make the script executable
RUN chmod +x /tmp/wp_setup.sh

# Start WordPress setup script and PHP-FPM in foreground
CMD ["/tmp/wp_setup.sh"]
