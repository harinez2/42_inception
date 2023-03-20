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
	&& apt-get clean

RUN  echo "########## Installing wordpress..."
#RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	wordpress \
	&& apt-get clean

EXPOSE 9000

RUN  echo "########## Finished!"

# commands for runnning container
# CMD exec mysqld_safe
