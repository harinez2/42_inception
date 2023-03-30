#!/bin/bash

################################################################
# wordpress

# wait for mysql to run
while ! echo "QUIT" | mysql -hmariadb -u${MYSQL_USER_NAME} -p${MYSQL_USER_PASSWD} &>/dev/null; do
    sleep 1
done

# log file
log_file=wpcli_installation.log

# create a new wp-config.php file
cd ${WP_HOME_PATH}
echo "wp config create-------------------" >>$log_file
wp config create --allow-root \
	--dbname=${MYSQL_DB_NAME} \
	--dbuser=${MYSQL_USER_NAME} \
	--dbpass=${MYSQL_USER_PASSWD} \
	--dbhost=mariadb \
	--path=${WP_HOME_PATH} \
	>>$log_file

# create the db based on wp-config.php
echo "wp db create-------------------" >>$log_file
wp db create --allow-root \
	>>$log_file

# install wp
echo "wp core install-------------------" >>$log_file
wp core install --allow-root \
	--url=https://${SITE_DOMAIN_NAME} \
	--title="${WP_SITE_TITLE}" \
	--admin_user=${WP_ADMIN_NAME} \
	--admin_password=${WP_ADMIN_PASSWD} \
	--admin_email=${SITE_EMAIL} \
	>>$log_file

# add editor user to wp
echo "wp user create-------------------" >>$log_file
wp user create \
	${WP_EDITOR_NAME} \
	"dummy@example.com" \
	--role=editor \
	--user_pass=${WP_EDITOR_PASSWD} \
	--allow-root \
	>>$log_file

echo -e "\n" >>$log_file

################################################################
# php

mkdir -p /run/php/
php-fpm7.3 --nodaemonize --allow-to-run-as-root
