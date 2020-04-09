#!/bin/bash

#php-fpm是前台运行的，因此其它进程需要在前面运行
/data/wwwroot/docker/php/start_before.sh &

echo 'php进程'
php-fpm