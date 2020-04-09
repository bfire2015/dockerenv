#!/bin/bash
name='ch-mongo-io'
tag='3.4.23'

cmd(){
	cmd="docker run --name $name \
	--restart=always \
	--network ch-net \
	-v /data/wwwroot:/data/wwwroot \
	-v /data/disk1:/data/disk1 \
	$(vmhost $2) -d $1"
	run "$cmd"
}

. ../../run.sh