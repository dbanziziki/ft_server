FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install nginx wget mariadb-server -y
RUN apt-get install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring -y

RUN mkdir /etc/nginx/ssl

#phpmyadmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-english.tar.gz && rm -rf phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english /var/www/html/phpmyadmin
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin

#wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
RUN mv wordpress /var/www/html
COPY ./srcs/wp-config.php /var/www/html

#nginx
COPY ./srcs/nginx.conf /etc/nginx/sites-available/default

#RUN openssl req -x509 -nodes -days 365 -subj "/C=KR/ST=Belgium/L=Brussels/O=innoaca/OU=42seoul/CN=dbnz" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data /var/www/html/

COPY ./srcs/server.sh /

ENTRYPOINT [ "/bin/bash", "-C", "server.sh" ]