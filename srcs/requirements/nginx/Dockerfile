FROM debian:oldstable

# Install nginx and openssl
RUN apt update -y && apt upgrade -y \
    && apt install nginx openssl -y \
    && apt-get clean

# Generate a self-signed ssl certificate
RUN openssl req -batch -x509 -sha256 -nodes -newkey rsa:2048 -days 365 \
	-keyout /etc/ssl/private/bda-mota.key \
	-out /etc/ssl/certs/bda-mota.crt \
	-subj "/C=Br/ST=SP/L=Sao Paulo/O=42sp/CN=bda-mota.42.fr"

# Copy the nginx configuration file
COPY ./conf/https.conf /etc/nginx/conf.d

# Expose port 443 ( https ) ********************
EXPOSE 443 

# Adjusts the permissions of the directory where web files are stored
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www

# Start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]