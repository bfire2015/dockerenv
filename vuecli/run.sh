#!/bin/bash
name='ch-vuecli'
tag='3.0'

cmd(){
	cmd="docker run --name $name \
	--restart=always \
	--network ch-net \
	-v /data/wwwroot:/data/wwwroot \
	-v /data/docker/data/vuecli:/root/.vue-cli-ui \
	-p 8000:8000 -p 8080:8080 -p 8081:8081 -p 8082:8082 \
	-d $1"
	run "$cmd"
}

. ../run.sh