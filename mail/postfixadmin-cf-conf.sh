#!/bin/bash

KEY=$1
VALUE=$2

CONF_FILE=/usr/share/postfixadmin/config.inc.php
CONTAINER_ID=rowlandsio_mail_1
REPLACE="$KEY = $VALUE"

docker --tls=1 exec $CONTAINER_ID sed -i "/$KEY/c$REPLACE" /etc/postfix/mysql_relay_domains_maps.cf
docker --tls=1 exec $CONTAINER_ID sed -i "/$KEY/c$REPLACE" /etc/postfix/mysql_virtual_alias_maps.cf
docker --tls=1 exec $CONTAINER_ID sed -i "/$KEY/c$REPLACE" /etc/postfix/mysql_virtual_domains_maps.cf
docker --tls=1 exec $CONTAINER_ID sed -i "/$KEY/c$REPLACE" /etc/postfix/mysql_virtual_mailbox_limit_maps.cf
docker --tls=1 exec $CONTAINER_ID sed -i "/$KEY/c$REPLACE" /etc/postfix/mysql_virtual_mailbox_maps.cf

echo "Updated /etc/postfix/*.cf files."


