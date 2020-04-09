#!/bin/bash
echo '系统日志'
service rsyslog start

echo '定时任务'
service cron start

kfOnline=/data/wwwroot/bfire/kf/crontab/online.php
if [ -e $kfOnline ]; then
	echo '在线客户服务'
	su - www -c "php $kfOnline start -d"
else
	echo '无在线客服服务'
fi