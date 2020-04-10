FROM node:13.5-alpine

#维护者信息
MAINTAINER StevenAn<alz8888@qq.com>

RUN npm config set registry https://registry.npm.taobao.org
RUN npm install -g @vue/cli

RUN echo "alias ll='ls -laF --color=auto'" >> ~/.bashrc

CMD ["vue", "ui", "--host", "0.0.0.0", "--port", "8000", "--headless"]