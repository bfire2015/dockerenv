#!/bin/bash
cname='bf-openldap-web'
name='osixia/phpldapadmin'
tag='0.9.0'

cmd(){	
	cmd="docker run -p 388:80 --name $cname --restart=always --privileged -d $1"
	run "$cmd"
}

. ../../run.sh
