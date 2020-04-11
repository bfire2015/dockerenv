#!/bin/bash
cname='bf-openldap'
name='osixia/openldap'
tag='1.3.0'

cmd(){
	cmd="docker run --name $cname \
	--restart=always \
	--network bf-net \
	--hostname openldap-host \
	-v /data/wwwroot/dockerenv/openldap/data:/var/lib/ldap \
	-v /data/wwwroot/dockerenv/openldap/conf/slapd.d:/etc/ldap/slapd.d \
	-v /data/wwwroot/dockerenv/openldap/conffile:/home/ldap/conffile \
	-e LDAP_ADMIN_PASSWORD=bfireLDAP123$%^ \
	-p 389:389 -d $1"
	run "$cmd"
}

. ../run.sh
