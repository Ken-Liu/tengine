FROM debian:jessie

MAINTAINER liukunmcu "lkmcudevelope@gmail.com"

WORKDIR /tengine
ADD . /tengine
RUN ./configure
RUN make
RUN make install
# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/cache/nginx"]

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
