FROM debian:buster

LABEL maintainer="yonishi@student.42tokyo.jp"

RUN echo "########## Installing fundamental tools..."
ARG DEBIAN_FRONTEND=noninteractive
ARG DEBCONF_NOWARNINGS=yes
# net-tools for netstat
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
	man \
	vim \
	curl \
	net-tools \
	&& apt-get clean

RUN  echo "########## Installing nginx..."
RUN  apt-get update && apt-get upgrade -y && apt-get install -y \
	 nginx \
	 && apt-get clean

RUN  echo "########## Configuring nginx..."
RUN  cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.original
COPY conf/nginx.default /etc/nginx/sites-available/default
RUN  rm /etc/nginx/sites-enabled/default \
	 && ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/

#RUN  echo "########## Setting up cert files..."
RUN  mkdir /etc/nginx/cert
COPY cert/* /etc/nginx/cert/

EXPOSE 443

RUN  echo "########## Finished!"

# start nginx in foreground
CMD ["nginx", "-g", "daemon off;"]
