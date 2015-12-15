FROM debian:jessie

MAINTAINER liukunmcu "lkmcudevelope@gmail.com"

WORKDIR /tengine
ADD . /tengine
RUN ./configure
RUN sed -i '$a deb http://ftp.de.debian.org/debian testing main non-free contrib' /etc/apt/sources.list
RUN sed -i '$a deb http://archive.debian.org/debian-archive/debian sarge main contrib non-free' /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y -t install make gcc
RUN sed '$d' -i /etc/apt/sources.list
RUN sed '$d' -i /etc/apt/sources.list
RUN make
RUN make install
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
