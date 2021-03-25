#!/bin/bash
mkdir /etc/ssl
openssl req -x509 -nodes -days 365 -subj "/C=KR/ST=Belgium/L=Brussels/O=innoaca/OU=42seoul/CN=dbnz" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;
service php7.3-fpm start
service nginx start
service mysql start

# Configure a wordpress database
echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

bash