FROM alpine:3.11.2

MAINTAINER StevenAn<alz8888@qq.com>

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --update bash bash-doc bash-completion
RUN apk add --no-cache certbot=1.0.0-r0 nodejs=12.15.0-r1
RUN rm -rf /var/cache/apk/*

RUN echo "alias ll='ls -laF --color=auto --time-style \"+[%Y-%m-%d %H:%M:%S]\"'" >> ~/.bashrc
RUN echo 'Asia/Shanghai' > /etc/timezone && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
COPY crontab /etc/crontabs/root

VOLUME ["/data/wwwroot/", "/etc/letsencrypt/"]

WORKDIR /data/wwwroot/

EXPOSE 8888

CMD ["/data/wwwroot/docker/certbot/start.sh"]