#!/bin/bash
name='ch-mariadb'
tag='10.4.11'

cmd(){
	cmd="docker run --name $name \
	--restart=always \
	--network bf-net \
	-v /data/docker/mysql/db:/var/lib/mysql \
	-v /data/docker/mysql/log:/var/log/mysql \
	-v /data/wwwroot/docker/mariadb/my.cnf:/etc/mysql/my.cnf \
	-d $1"
	run "$cmd"
}

. ../run.sh