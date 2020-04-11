# dockerenv
about service app env for php,nginx,redis,mysql,phpmyadmin

目前已安装app功能:

1、php

2、nginx

3、portainer


# 写在前面
开放端口注册：
9999			docker管理后台

5000/5001		仓库/UI

80/443			http/https

389				openldap

27018			mongodb

9200			elasticsearch

3307			phpmyadmin


# 一、环境安装
安装docker：

yum install -y docker



版本查看：

docker version



开机自启：

systemctl enable docker



加速配置：

echo '{"registry-mirrors": ["http://hub-mirror.c.163.com", "http://f1361db2.m.daocloud.io"]}' > /etc/docker/daemon.json



容器服务启动：

systemctl start docker



信息查看：

docker info


# 二、获取代码

## 1、项目位置
mkdir 755 /data/wwwroot/

## 2、拉取源码
git clone https://github.com/bfire2015/dockerenv.git

# 三、安装网络

  docker network create -d bridge bf-net

# 四、启动docker

## 1、注意文件可执行权限

/data/wwwroot/dockerenv/
chmod 777 ./run.sh


## 2、各个项目下的run.sh 

chmod 777 ./run.sh

  cd /data/wwwroot/dockerenv/portainer/ && ./run.sh run vm reset （可视化管理工具portainer）

  cd /data/wwwroot/dockerenv/php/ && ./run.sh run vm reset

  cd /data/wwwroot/dockerenv/nginx/ && ./run.sh run vm reset

  cd /data/wwwroot/dockerenv/mongo/ && ./run.sh run vm reset def

  cd /data/wwwroot/dockerenv/mongo/io/ && ./run.sh run vm reset （同步db要用）