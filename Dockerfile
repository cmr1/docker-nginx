FROM alpine:3.5

MAINTAINER Charlie McClung <charlie@cmr1.com>

RUN apk add --no-cache \
  gcc \
  bash \
  curl \
  make \
  perl \
  musl-dev \
  pcre-dev \
  zlib-dev \
  libssl1.0

RUN curl https://www.openssl.org/source/openssl-1.0.2j.tar.gz -o /tmp/openssl-1.0.2j.tar.gz
RUN curl https://openresty.org/download/openresty-1.11.2.2.tar.gz -o /tmp/openresty-1.11.2.2.tar.gz

RUN tar xf /tmp/openssl-1.0.2j.tar.gz -C /usr/local
RUN tar xf /tmp/openresty-1.11.2.2.tar.gz -C /tmp

WORKDIR /tmp/openresty-1.11.2.2

RUN ./configure \
  --prefix=/usr/local/openresty \
  --with-openssl=/usr/local/openssl-1.0.2j \
  --with-debug \
  --with-http_v2_module \
  --with-http_realip_module

RUN make && make install

RUN rm -rf /tmp/open*

# Start nginx in the foreground to play nicely with Docker.
CMD ["/usr/local/openresty/nginx/sbin/nginx", "-g", "daemon off;"]
