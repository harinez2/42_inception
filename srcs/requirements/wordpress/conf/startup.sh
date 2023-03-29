#!/bin/bash

################################################################
# wordpress

# create a new wp-config.php file
wp config create --allow-root \
	--dbname=${MYSQL_DB_NAME} \
	--dbuser=root \
	--prompt=${MYSQL_ROOT_PASSWD} \
	--dbhost=mariadb

# create the db based on wp-config.php
wp db create

# install wp
wp core install \
	--url=${WP_HOMEPATH} \
	--title=${WP_SITE_TITLE} \
	--admin_user=${MYSQL_USER_NAME} \
	--admin_password=${MYSQL_USER_PASSWD} \
	--admin_email=example@example.com

################################################################
# php

mkdir -p /run/php/
php-fpm7.3 --nodaemonize --allow-to-run-as-root
