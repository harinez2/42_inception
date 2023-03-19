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
	expect \
	&& apt-get clean

RUN  echo "########## Installing mariadb..."
#RUN groupadd -r mysql && useradd -r -g mysql mysql
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	mariadb-server \
	&& apt-get clean

RUN  echo "########## Configuring mariadb..."
COPY conf/init_mariadb_config.sh /tmp
RUN  cd /tmp && ./init_mariadb_config.sh

#RUN  echo "########## Setting up cert files..."
# RUN  mkdir /etc/nginx/cert
# COPY cert/* /etc/nginx/cert/

EXPOSE 3306

RUN  echo "########## Finished!"

# commands for runnning container
CMD exec mysqld_safe
