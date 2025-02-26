ARG VERSION=1.27.4

FROM nginx:${VERSION}-alpine AS builder

ARG VERSION=1.27.4
ENV NGINX_VERSION=${VERSION}

RUN apk add --update --no-cache --virtual .build-deps \
    curl \
    gd-dev \
    geoip-dev \
    libc-dev \
    libxslt-dev \
    linux-headers \
    make \
    openssl-dev \
    pcre-dev \
    zlib-dev \
    gcc \
    git \
    tar

RUN git clone https://github.com/vozlt/nginx-module-vts.git
RUN curl -LO https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz  && tar -zxf nginx-${NGINX_VERSION}.tar.gz

WORKDIR /nginx-${NGINX_VERSION}

RUN CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p')
RUN ./configure --with-compat $CONFARGS --add-dynamic-module=../nginx-module-vts && make modules
RUN cp objs/ngx_http_vhost_traffic_status_module.so /usr/lib/nginx/modules/ngx_http_vhost_traffic_status_module.so

FROM nginx:${VERSION}-alpine

COPY --from=builder /usr/lib/nginx/modules/ngx_http_vhost_traffic_status_module.so /etc/nginx/modules

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80 443 9991

CMD ["nginx", "-g", "daemon off;"]
