FROM debian:wheezy

MAINTAINER liukunmcu "lkmcudevelope@gmail.com"

WORKDIR /tengine
ADD . /tengine
RUN apt-get update
RUN apt-get -y  install make
RUN apt-get -y  install gcc
RUN apt-get install libpcre3 libpcre3-dev libpcrecpp0 libssl-dev zlib1g-dev
RUN ./configure
RUN make
RUN make install
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
