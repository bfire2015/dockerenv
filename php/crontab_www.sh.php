#!/bin/sh
#<?php die();?>
log(){
	echo $(date "+[%Y-%m-%d %H:%M:%S]")' '$1 >> /var/log/crontab_www.log
}

log 'start'

DIR=/data/wwwroot/bfire/
if [ -d $DIR ]; then
	php -f ${DIR}auth/crontab/core.php > /dev/null 2>&1 &
	php -f ${DIR}sa/crontab/core.php > /dev/null 2>&1 &
	php -f ${DIR}zh/crontab/core.php > /dev/null 2>&1 &
	php -f ${DIR}zh/crontab/async.php > /dev/null 2>&1 &
	php -f ${DIR}open/crontab/async.php > /dev/null 2>&1 &
	php -f ${DIR}kms/crontab/core.php > /dev/null 2>&1 &
fi

DIR=/data/wwwroot/bfire/
if [ -d $DIR ]; then
	php -f ${DIR}sa/crontab/core.php > /dev/null 2>&1 &
fi

log 'end'