FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y

RUN apt-get install nginx wget mariadb-server -y
RUN apt-get install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring -y

ENV AUTOINDEX on

RUN echo "daemon off;" >> /etc/nginx/nginx.conf && \ 
        rm var/www/html/index.nginx-debian.html

COPY	srcs/*.conf /tmp/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.2/phpMyAdmin-5.0.2-english.tar.gz && \
    tar -xzvf phpMyAdmin-5.0.2-english.tar.gz && \
    mv phpMyAdmin-5.0.2-english/ /var/www/html/phpmyadmin && \
    rm -rf phpMyAdmin-5.0.2-english.tar.gz
COPY srcs/config.inc.php /var/www/html/phpmyadmin

RUN wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    mv wordpress /var/www/html/ && \
    rm -rf latest.tar.gz
COPY srcs/wp-config.php /var/www/html/wordpress

RUN openssl req -x509 -nodes -days 365 -subj "/C=KR/ST=Belgium/L=Brussels/O=innoaca/OU=19bx/CN=dbnz" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data /var/www/html/*

COPY srcs/*.sh ./

ENTRYPOINT [ "/bin/bash", "-C", "server.sh" ]
