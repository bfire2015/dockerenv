#!/bin/bash
name='ch-mariadb-web'
tag='5.0.1'

cmd(){
	cmd="docker run --name $name \
	--restart=always \
	--network ch-net \
	-e PMA_ARBITRARY=1 \
	-p 3307:80 -d $1"
	run "$cmd"
}

. ../../run.sh