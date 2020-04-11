FROM mongo:3.4.23

MAINTAINER bfire<bfire2013@gmail.com>

ADD mongod.conf /etc/

RUN chown mongodb.mongodb /etc/mongod.conf

RUN echo "alias ll='ls -laF --color=auto'" >> ~/.bashrc

EXPOSE 27017

CMD ["mongod", "-f", "/etc/mongod.conf"]