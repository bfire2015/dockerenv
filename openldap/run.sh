#!/bin/bash
name='ch-openldap'
tag='1.3.0'

cmd(){
	cmd="docker run --name $name \
	--restart=always \
	--network ch-net \
	--hostname openldap-host \
	-v /data/wwwroot/docker/openldap/data:/var/lib/ldap \
	-v /data/wwwroot/docker/openldap/conf/slapd.d:/etc/ldap/slapd.d \
	-v /data/wwwroot/docker/openldap/conffile:/home/ldap/conffile \
	-e LDAP_ADMIN_PASSWORD=bfireLDAP123$%^ \
	-p 389:389 -d $1"
	run "$cmd"
}

. ../run.sh