#!/bin/bash

################################################################
# wordpress

# wait for mysql to run
while ! mysql -h mariadb -u root -p ${MYSQL_ROOT_PASSWD} ${MYSQL_DB_NAME} &>/dev/null; do
    sleep 1
done

# create a new wp-config.php file
cd ${WP_HOME_PATH}
wp config create --allow-root \
	--dbname=${MYSQL_DB_NAME} \
	--dbuser=root \
	--prompt=${MYSQL_ROOT_PASSWD} \
	--dbhost=mariadb

# create the db based on wp-config.php
wp db create

# install wp
wp core install \
	--url=${WP_HOME_PATH} \
	--title=${WP_SITE_TITLE} \
	--admin_user=${MYSQL_USER_NAME} \
	--admin_password=${MYSQL_USER_PASSWD} \
	--admin_email=example@example.com

################################################################
# php

mkdir -p /run/php/
php-fpm7.3 --nodaemonize --allow-to-run-as-root
