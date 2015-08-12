#!/bin/bash

KEY=$1
VALUE=$2

CONF_FILE=/usr/share/postfixadmin/config.inc.php
CONTAINER_ID=rowlandsio_mail_1

REPLACE="\$CONF['$KEY'] = '$VALUE';"
docker --tls=1 exec rowlandsio_mail_1 sed -i "/'$KEY'/c$REPLACE" $CONF_FILE
CONF_FILE=/usr/share/postfixadmin/config.inc.php
echo "conf.inc.php updated to: `docker --tls exec $CONTAINER_ID cat $CONF_FILE | grep $KEY`"


#echo "conf.inc.php updated to: `docker --tls exec $CONTAINER_ID cat $CONF_FILE`"
