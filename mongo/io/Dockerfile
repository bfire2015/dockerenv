FROM mongo:3.4.23
MAINTAINER StevenAn<alz8888@qq.com>
RUN echo "www:x:1000:1000::/home:/bin/sh" >> /etc/passwd
RUN echo "vboxsf:x:995:root,www" >> /etc/group
RUN echo "www:x:1000:" >> /etc/group
RUN echo "alias ll='ls -laF --color=auto'" >> ~/.bashrc
RUN echo 'Asia/Shanghai' > /etc/timezone && ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
CMD ["/data/wwwroot/docker/mongo/io/start.sh"]