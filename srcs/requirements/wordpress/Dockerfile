FROM debian:buster

LABEL maintainer="yonishi@student.42tokyo.jp"

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
	&& apt-get clean

RUN  echo "########## Installing wordpress..."
#RUN groupadd -r mysql && useradd -r -g mysql mysql
# RUN apt-get update && apt-get upgrade -y && apt-get install -y \
# 	wordpress \
# 	&& apt-get clean
COPY conf/wordpress-6.1.1-ja.tar.gz /
RUN  tar zxf wordpress-6.1.1-ja.tar.gz \
	&& mkdir -p /vol_wp/wordpress \
	&& mv wordpress /vol_wp/ \
	&& rm wordpress-6.1.1-ja.tar.gz
RUN  sudo chmod -R 777 /vol_wp/wordpress/
# RUN  sudo chown -R www-data:www-data /vol_wp/wordpress/

EXPOSE 9000

RUN  echo "########## Finished!"
COPY ./conf/startup.sh ./startup.sh
RUN chmod +x startup.sh
CMD ["bash", "./startup.sh"]
