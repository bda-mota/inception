#!/usr/bin/env bash

# Verifica se o WordPress já está instalado
if wp core is-installed --allow-root --path=/var/www/html; then
    echo "✅ WordPress já está instalado, pulando configuração."
else
    echo "⚙️ Configurando WordPress pela primeira vez..."

    # Cria o arquivo wp-config.php
    wp --allow-root config create \
        --dbname="$DATABASE_NAME" \
        --dbuser="$ADMIN_NAME" \
        --dbpass="$ADMIN_PASSWORD" \
        --dbhost=mariadb \
        --dbprefix="wp_"

    # Instala o WordPress
    wp core install --allow-root \
        --path=/var/www/html \
        --title="$WP_TITLE" \
        --url="$DOMAIN" \
        --admin_user="$ADMIN_NAME" \
        --admin_password="$ADMIN_PASSWORD" \
        --admin_email="$ADMIN_EMAIL"

    # Cria um usuário adicional
    wp user create --allow-root \
        --path=/var/www/html \
        "$USER_NAME" \
        "$USER_EMAIL" \
        --user_pass="$USER_PASSWORD" \
        --role='author'

    # Ativa o tema padrão
    wp --allow-root theme activate twentytwentyfour
fi

# Inicia o PHP-FPM
exec php-fpm7.4 -F