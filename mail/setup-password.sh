#!/bin/bash


SETUP_PASSWORD_HASH=ee0adaf9a996c9b91d0f9ce222ac57fd:b2149bc5be83c607ad100ebade7cd49b9d50570e
REPLACE="\$CONF['setup_password'] = '$SETUP_PASSWORD_HASH';"
docker --tls=1 exec rowlandsio_mail_1 sed -i "/'setup_password'/c$REPLACE" /usr/share/postfixadmin/config.inc.php
echo "conf.inc.php updated to: `docker --tls exec rowlandsio_mail_1 cat /usr/share/postfixadmin/config.inc.php | grep setup_password`"

#docker exec mail sed -i "/'setup_password'/c\$CONF['setup_password'] = 'a894f49226cc4e8a2f45e76a51544bf4:9ea5ecc7cf4523c5f98c155420f57a116a7649b9';" /usr/share/postfixadmin/config.inc.php
#echo "conf.inc.php updated to: `docker exec mail cat /usr/share/postfixadmin/config.inc.php | grep setup_password`"



#docker --tls=1 exec rowlandsio_mail_1 sed -i "/'setup_password'/c$REPLACE" /usr/share/postfixadmin/config.inc.php
#echo "conf.inc.php updated to: `docker --tls exec rowlandsio_mail_1 cat /usr/share/postfixadmin/config.inc.php | grep dbtype`"
