#!/usr/bin/env bash

# create file wp-config.php
wp --allow-root config create \
	--dbname="$DATABASE_NAME" \
	--dbuser="$ADMIN_NAME" \
	--dbpass="$ADMIN_PASSWORD" \
	--dbhost=mariadb \
	--dbprefix="wp_"

# WordPress
wp core install --allow-root \
	--path=/var/www/html \
	--title="$WP_TITLE" \
	--url="$DOMAIN" \
	--admin_user="$ADMIN_NAME" \
	--admin_password="$ADMIN_PASSWORD" \
	--admin_email="$ADMIN_EMAIL"

# create user 
wp user create --allow-root \
	--path=/var/www/html \
	"$USER_NAME" \
	"$USER_EMAIL" \
	--user_pass="$USER_PASSWORD" \
	--role='author'

# theme
wp --allow-root theme activate twentytwentyfour

# start PHP-FPM
exec php-fpm7.4 -F