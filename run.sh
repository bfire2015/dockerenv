#!/bin/bash

#开放端口注册：
#9999			docker管理后台
#5000/5001		仓库/UI
#80/443			http/https
#389			openldap
#27018			mongodb
#3690			svnserver
#9200			elasticsearch
#8088			tomcat
#3307			phpmyadmin
#8181			icbc

#./run.sh build/push/pull/run/dev vm/demo/on reset

#运行
run(){
	tip "运行【$1】"
	echo `$1`
}

#重置容器
reset(){
	tip '停止容器'
	docker stop $name
	tip '删除容器'
	docker rm $name
}

#本地环境添加host到容器
vmhost(){
	if [ $1 == 'vm' ]; then
		ret='--add-host vm-bfire.vip:10.0.2.15 --add-host syslib.vm-bfire.vip:10.0.2.15 --add-host pay.vm-bfire.vip:10.0.2.15 --add-host auth.vm-bfire.vip:10.0.2.15 --add-host zh.vm-bfire.vip:10.0.2.15 --add-host open.vm-bfire.vip:10.0.2.15 --add-host sa.vm-bfire.vip:10.0.2.15 --add-host demo-bfire.vip:192.168.2.252'
	elif [ $1 == 'demo' ]; then
		ret='--add-host demo-bfire.vip:192.168.2.252 --add-host syslib.demo-bfire.vip:192.168.2.252 --add-host auth.demo-bfire.vip:192.168.2.252 --add-host zh.demo-bfire.vip:192.168.2.252'
	else
		ret=''
	fi
	echo $ret
}

#提示信息
tip(){
	echo -e "\033[33m $1 \033[0m"
}

#错误信息
err(){
	echo -e "\033[41;37m $1 \033[0m"
}

#初始化事件
names=$name:$tag
namefull='docker.bfire.vip/'$names
fonts=/data/wwwroot/docker/@fonts/

if [[ $1 && $1 = 'dev' ]]; then #使用本地的镜像运行
	tip '开发运行 '$names
	reset
	cmd $names vm
elif [[ $1 && $1 = 'run' ]]; then #使用仓库中的镜像运行
	if [[ $2 != 'on' && $2 != 'vm' && $2 != 'demo' ]]; then
		err '错误指令 ./run.sh run vm/demo/on reset/空'
		exit
	fi
	if [ "$(type -t run_before)" = "function" ] ; then #运行前置方法
		run_before $namefull $2 $4
	fi
	docker pull $namefull
	if [[ $3 && $3 = 'reset' ]]; then #重置命令
		reset
	fi
	cmd $namefull $2 $4
	if [ "$(type -t run_end)" = "function" ] ; then #运行后置方法
		run_end $namefull $2 $4
	fi
elif [[ $1 && $1 = 'build' ]]; then #构建镜像
	tip '构建 '$names
	if [ "$(type -t build_before)" = "function" ] ; then #构建前置方法
		build_before
	fi
	docker build -t $names .
	if [ "$(type -t build_end)" = "function" ] ; then #构建后置方法
		build_end
	fi
elif [[ $1 && $1 = 'push' ]]; then
	tip '推送到服务器 '$namefull
	docker tag $names $namefull
	docker push $namefull
elif [[ $1 && $1 = 'pull' ]]; then
	tip '从仓库拉取镜像 '$namefull
	docker pull $namefull
else
	err '错误指令 ./run.sh build/dev/push 或 ./run.sh run vm/demo/on reset'
fi