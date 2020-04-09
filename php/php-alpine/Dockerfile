FROM alpine:3.8

#维护者信息
MAINTAINER StevenAn<alz8888@qq.com>

RUN echo "www:x:1000:1000::/home:/bin/sh" >> /etc/passwd
RUN echo "vboxsf:x:995:root,www" >> /etc/group
RUN echo "www:x:1000:" >> /etc/group

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --update bash bash-doc bash-completion

RUN apk add --update php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip

RUN apk add --update php7-mysqli php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-curl php7-ctype php7-redis

RUn apk add --update php7-mongodb php7-exif php7-swoole

RUN rm -rf /var/cache/apk/*

RUN echo "alias ll='ls -laF --color=auto'" >> ~/.bashrc
RUN echo 'Asia/Shanghai' > /etc/timezone && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

VOLUME ["/data/wwwroot/"]

WORKDIR /data/wwwroot

#EXPOSE 映射端口
EXPOSE 9000

CMD ["php-fpm7", "-F"]