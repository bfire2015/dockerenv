#!/bin/bash
name='ch-openldap-web'
tag='0.9.0'

cmd(){	
	cmd="docker run -p 388:80 --name $name --restart=always --privileged -d $1"
	run "$cmd"
}

. ../../run.sh