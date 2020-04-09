#!/bin/bash
name='ch-php'
tag='7.2.4'

cmd(){
	if [ $2 = 'vm' ]; then
		conf='-vm'
	elif [ $2 = 'demo' ]; then
		conf='-vm'
	else
		conf=''
	fi
	cmd="docker run --name $name \
	-e SERVER_TYPE=$2 \
	--restart=always \
	--network ch-net \
	-v /data/wwwroot/docker/php/php$conf.ini:/etc/php7/php.ini \
	-v /data/wwwroot/docker/php/php-fpm$conf.conf:/etc/php7/php-fpm.conf \
	-v /data/wwwroot/docker/php/php-fpm.d:/etc/php7/php-fpm.d \
	-v /data/docker/log/php:/var/log/php-fpm \
	-v /data/docker/data/php:/var/lib/php \
	-v /data/wwwroot:/data/wwwroot \
	-v /data/disk1/:/data/disk1/ \
	-v /data/svn/:/data/svn/ \
	$(vmhost $2) -d $1"
	run "$cmd"
}

. ../run.sh