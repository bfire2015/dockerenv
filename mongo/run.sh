#!/bin/bash
name='ch-mongo'
tag='3.4.23'

run_before(){
	if [ $3 = 'ssd' ]; then
		dbPath=/data/disk0/mongo
	elif [ $3 = 'def' ]; then
		dbPath=/data/docker/mongo
	else
		err '请输入正确的第四个参数 ./run.sh run vm/demo/on reset ssd/def'
		exit
	fi
}

cmd(){
	cmd="docker run --name $name \
	--restart=always \
	--network bf-net \
	-v /data/wwwroot:/data/wwwroot \
	-v $dbPath:/data/db \
	-v $dbPath/config:/data/configdb \
	-p 27018:27017 -d $1"

	run "$cmd"
}

. ../run.sh