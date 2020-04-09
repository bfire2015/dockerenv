#!/bin/bash
#要用root用户跑
name='ch-portainer'
tag='1.23.0'

cmd(){
	cmd="docker run --name $name \
	--restart=always \
	-v /data/docker/portainer:/data \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-p 9999:9000 -d $1"
	run "$cmd"
}

. ../run.sh