FROM tutum/lamp:latest
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

# Download latest version of Wordpress into /app
RUN rm -fr /app && git clone --depth=1 https://github.com/WordPress/WordPress.git /app

# Configure Wordpress to connect to local DB
ADD wp-config.php /app/wp-config.php

# Modify permissions to allow plugin upload
RUN chown -R www-data:www-data /app/wp-content /var/www/html

# Add database setup script
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD create_db.sh /create_db.sh
RUN chmod +x /*.sh

# Add volumes for MySQL 
VOLUME  ["/etc/mysql", "/var/lib/mysql" ]

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssl


#Configure SSL
#---Activate the SSL Module   
RUN a2enmod ssl
RUN service apache2 restart
#---Create the SSL Dir
RUN mkdir /etc/apache2/ssl 
#---Create Self-Signed SSL Certificate
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt -subj '/O=Dell/OU=MarketPlace/CN=www.dell.com'
#---Copy the config file that uses the new SSL key pairs
ADD default-ssl.conf /etc/apache2/sites-available/default-ssl.conf 
#---Activate the new virtual host  
RUN a2ensite default-ssl
RUN service apache2 restart

EXPOSE 80 3306 443
CMD ["/run.sh"]
