FROM debian:buster

LABEL maintainer="yonishi@student.42tokyo.jp"
ARG MYSQL_ROOT_PASSWD
ARG MYSQL_DB_NAME
ARG MYSQL_USER_NAME
ARG MYSQL_USER_PASSWD

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
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	mariadb-server \
	&& apt-get clean

RUN  echo "########## Configuring mariadb..."
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/
RUN chmod 644 /etc/mysql/mariadb.conf.d/50-server.cnf
RUN mysql_install_db --basedir=/usr --datadir=/vol_db/mysql --user=mysql

RUN  echo "########## Initializing mariadb..."
COPY conf/init_mariadb_config.sh /
ENV MYSQL_ROOT_PASSWD=${MYSQL_ROOT_PASSWD}
ENV MYSQL_USER_NAME=${MYSQL_USER_NAME}
ENV MYSQL_USER_PASSWD=${MYSQL_USER_PASSWD}
RUN chmod +x init_mariadb_config.sh
RUN cd / && ./init_mariadb_config.sh

# EXPOSE 3306

RUN  echo "########## Finished!"

# commands for runnning container
CMD exec mysqld_safe
