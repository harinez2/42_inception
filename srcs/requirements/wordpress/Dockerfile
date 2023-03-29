FROM debian:buster

LABEL maintainer="yonishi@student.42tokyo.jp"
ARG MYSQL_ROOT_PASSWD
ARG MYSQL_USER_NAME
ARG MYSQL_USER_PASSWD
ARG MYSQL_DB_NAME

RUN echo "########## Installing fundamental tools..."
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NOWARNINGS=yes
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	man \
	vim \
	curl \
	sudo \
	&& apt-get clean

RUN  echo "########## Installing php ..."
#RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	php \
	php-mysql \
	php-curl \
	php-gd \
	php-mbstring \
	php-xml \
	php-xmlrpc \
	php-soap \
	php-intl \
	php-zip \
	php-fpm \
	mariadb-client \
	&& apt-get clean

RUN  echo "########## Installing wordpress..."
#RUN groupadd -r mysql && useradd -r -g mysql mysql
# RUN apt-get update && apt-get upgrade -y && apt-get install -y \
# 	wordpress \
# 	&& apt-get clean

# COPY conf/wordpress-6.1.1-ja.tar.gz /
# RUN  tar zxf wordpress-6.1.1-ja.tar.gz \
# 	&& mkdir -p /home/yonishi/data/wordpress \
# 	&& mv wordpress /home/yonishi/data/ \
# 	&& rm wordpress-6.1.1-ja.tar.gz
# RUN  sudo chmod -R 777 /home/yonishi/
# RUN  sudo chown -R www-data:www-data /home/yonishi/

# setup WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN sudo mv wp-cli.phar /usr/local/bin/wp
# download wp
RUN mkdir -p /home/yonishi/data/
WORKDIR /home/yonishi/data/
RUN wp core download --allow-root --path=/home/yonishi/data/
# create a new wp-config.php file
RUN wp config create --allow-root \
	--dbname=${MYSQL_DB_NAME} --dbuser=root --prompt=${MYSQL_ROOT_PASSWD} \
	--dbhost=mariadb
# create the db based on wp-config.php
RUN wp db create
# install wp
RUN wp core install --url=/home/yonishi/data/ --title="inception 42" \
	--admin_user=${MYSQL_USER_NAME} --admin_password=${MYSQL_USER_PASSWD} --admin_email=example@example.com

RUN  echo "########## Configuring php-fpm..."
RUN  mv /etc/php/7.3/fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/www.conf.original
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

EXPOSE 9000

RUN  echo "########## Finished!"
COPY ./conf/startup.sh ./startup.sh
RUN chmod +x startup.sh
CMD ["bash", "./startup.sh"]
