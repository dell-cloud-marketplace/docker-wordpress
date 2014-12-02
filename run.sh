#!/bin/bash

VOLUME_HOME="/var/lib/mysql"

sed -ri -e "s/^upload_max_filesize.*/upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}/" \
    -e "s/^post_max_size.*/post_max_size = ${PHP_POST_MAX_SIZE}/" /etc/php5/apache2/php.ini
if [[ ! -d $VOLUME_HOME/mysql ]]; then
    echo "=> An empty or uninitialized MySQL volume is detected in $VOLUME_HOME"
    echo "=> Installing MySQL ..."
    mysql_install_db > /dev/null 2>&1
    echo "=> Done!"  
    /create_mysql_admin_user.sh
else
    echo "=> Using an existing volume of MySQL"
fi

APPLICATION_HOME="/var/www/html"

# If the application directory is empty, copy the site.
if [ ! "$(ls -A $APPLICATION_HOME)" ]; then
    echo "=> Copying the site"

    # Copy the application folder.
    cp -r /app/. $APPLICATION_HOME

    # Configure ownership to allow plugin upload.
    chown -R www-data:www-data $APPLICATION_HOME/wp-content
fi

exec supervisord -n
