FROM dell/lamp-base:1.1
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

# Download Wordpress 4.0 into /app
RUN rm -fr /var/www/html
RUN rm -fr /app && git clone -b 4.1-branch --single-branch --depth=1 \
    https://github.com/WordPress/WordPress.git /app 

# Configure Wordpress to connect to local DB
COPY wp-config.php /app/wp-config.php

# Add htaccess
COPY .htaccess /app/.htaccess

# Override Apache configuration
COPY apache_default /etc/apache2/sites-available/000-default.conf

# Add scripts and make them executable.
COPY create_mysql_admin_user.sh /create_mysql_admin_user.sh
COPY create_db.sh /create_db.sh
COPY run.sh /run.sh
RUN chmod +x /*.sh

# Add volumes for MySQL and the application.
VOLUME ["/var/lib/mysql", "/var/www/html"]

EXPOSE 80 3306 443

CMD ["/run.sh"]
