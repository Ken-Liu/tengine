FROM debian:wheezy

MAINTAINER liukunmcu "lkmcudevelope@gmail.com"

WORKDIR /tengine
ADD . /tengine
RUN apt-get update
RUN apt-get -y -t install make gcc
RUN sed '$d' -i /etc/apt/sources.list
RUN sed '$d' -i /etc/apt/sources.list
RUN ./configure
RUN make
RUN make install
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
