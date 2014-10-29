FROM dell/lamp-base:1.0
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

# Download Wordpress 4.0 into /app
RUN rm -fr /var/www/html
RUN ln -s /app /var/www/html
RUN rm -fr /app && git clone -b 4.0-branch --single-branch --depth=1 \
    https://github.com/WordPress/WordPress.git /app 

# Configure Wordpress to connect to local DB
ADD wp-config.php /app/wp-config.php

# Modify permissions to allow plugin upload
RUN chown -R www-data:www-data /app/wp-content /var/www/html

# Add scripts and make them executable.
ADD create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD create_db.sh /create_db.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

# Add volumes for MySQL 
VOLUME ['/var/lib/mysql', '/var/www/html']

EXPOSE 80 3306 443

CMD ["/run.sh"]
