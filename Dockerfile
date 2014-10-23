FROM dell/lamp-base:v0.1
MAINTAINER Dell Cloud Market Place <Cloud_Marketplace@dell.com>

ADD run.sh /run.sh
RUN chmod 755 /*.sh

RUN rm -fr /var/www/html
RUN ln -s /app /var/www/html

# Download Wordpress 4.0 into /app
RUN rm -fr /app && git clone -b 4.0-branch --single-branch --depth=1 https://github.com/WordPress/WordPress.git /app 

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

EXPOSE 80 3306 443
CMD ["/run.sh"]
