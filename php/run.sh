#!/bin/bash
name='ch-php'
tag='7.2.4'

cmd(){
	baseDir=/data/docker/php/
	mkdir -p ${baseDir}session/
	chown -R www.www $baseDir
	chmod -R 775 $baseDir

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
	-v /data/wwwroot/docker/php/php$conf.ini:/usr/local/etc/php/php.ini \
	-v /data/wwwroot/docker/php/php-fpm$conf.conf:/usr/local/etc/php-fpm.conf \
	-v /data/wwwroot/docker/php/php-fpm.d:/usr/local/etc/php-fpm.d \
	-v /data/docker/php:/var/log \
	-v /data/docker/php/php-fpm:/var/log/php-fpm \
	-v /data/docker/php/session:/var/lib/php/session \
	-v /data/wwwroot:/data/wwwroot \
	-v /data/disk1:/data/disk1 \
	-v /etc/letsencrypt:/etc/letsencrypt \
	-v /data/svn:/data/svn \
	-p 1688:1688 $(vmhost $2) -d $1"
	run "$cmd"
}

. ../run.sh