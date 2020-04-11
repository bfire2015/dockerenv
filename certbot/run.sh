#!/bin/bash
name='ch-certbot'
tag='1.0'

cmd(){
	cmd="docker run --name $name \
	--restart=always \
	--network bf-net \
	-v /data/wwwroot:/data/wwwroot \
	-v /data/docker/certbot:/var/log \
	-v /etc/letsencrypt:/etc/letsencrypt \
	-d $1"
	run "$cmd"
}

. ../run.sh