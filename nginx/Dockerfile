# 基础镜像
FROM daocloud.io/nginx:1.16.0-alpine

#维护者信息
MAINTAINER bfire<bfire2013@gmail.com>

RUN echo "www:x:1000:1000::/home:/bin/sh" >> /etc/passwd
RUN echo "vboxsf:x:995:root,www" >> /etc/group
RUN echo "www:x:1000:" >> /etc/group

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories && apk add --update bash bash-doc bash-completion && rm -rf /var/cache/apk/*
RUN echo "alias ll='ls -laF --color=auto'" >> ~/.bashrc

WORKDIR /data/wwwroot

EXPOSE 80 443

#CMD 运行以下命令，daemon off后台运行，否则启动完就自动关闭
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]