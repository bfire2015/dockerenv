#!/bin/bash
#要用root用户跑
cname='bf-portainer'
name='portainer/portainer'
tag='1.23.0'

cmd(){
	cmd="docker run --name $cname \
	--restart=always \
	-v /data/docker/portainer:/data \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v /data/wwwroot/dockerenv/portainer/lan_zh:/public
	-p 9999:9000 -d $1"
	run "$cmd"
}

. ../run.sh
