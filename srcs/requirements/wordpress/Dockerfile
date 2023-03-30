FROM debian:buster

LABEL maintainer="yonishi@student.42tokyo.jp"
ARG WP_HOME_PATH

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
# setup WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN sudo mv wp-cli.phar /usr/local/bin/wp
# download wp
RUN mkdir -p ${WP_HOME_PATH}
RUN wp core download --allow-root --path=${WP_HOME_PATH}

RUN  echo "########## Configuring php-fpm..."
RUN  mv /etc/php/7.3/fpm/pool.d/www.conf /etc/php/7.3/fpm/pool.d/www.conf.original
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/

# EXPOSE 9000

RUN  echo "########## Finished!"
COPY ./conf/startup.sh ./startup.sh
RUN chmod +x startup.sh
CMD ["/bin/bash", "./startup.sh"]
