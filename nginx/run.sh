#!/bin/bash
name='ch-nginx'
tag='1.16'

cmd(){
	baseDir=/data/docker/nginx/
	mkdir -p $baseDir
	chown -R www.www $baseDir
	chmod -R 775 $baseDir

	if [ $2 = 'vm' ]; then
		conf='conf.d-vm'
	elif [ $2 = 'demo' ]; then
		conf='conf.d-demo'
	elif [ $3 ]; then
		conf='conf.d-'$3
	else
		conf='conf.d'
	fi
	tip "配置目录【$conf】"
	cmd="docker run --name $name \
	--restart=always \
	--network bf-net \
	-v /data/wwwroot/docker/nginx/$conf:/etc/nginx/conf.d \
	-v /data/wwwroot/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
	-v /data/wwwroot/docker/nginx/conf:/etc/nginx/conf \
	-v /data/wwwroot:/data/wwwroot \
	-v /data/disk1:/data/disk1 \
	-v /data/docker/nginx:/var/log/nginx \
	-v /etc/letsencrypt:/etc/letsencrypt \
	-p 80:80 -p 443:443 -d $1"
	run "$cmd"
}

. ../run.sh