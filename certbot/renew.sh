#!/bin/bash
log=/var/log/renew.log
echo $(date "+[%Y-%m-%d %H:%M:%S]") >> $log
certbot renew >> $log