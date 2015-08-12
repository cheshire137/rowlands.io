#!/bin/bash


#docker --tls=1 exec --it rowlandsio_mail_1 mysql postfix -u postfix -p postfixpassword


#docker --tls=1 exec rowlandsio_mail_1 mysql -uroot -prootpassword  -e "SET PASSWORD FOR 'postfixadmin'@'localhost' = PASSWORD('postfixpassword');"

#docker --tls=1 exec rowlandsio_mail_1 mysql -upostfixadmin -ppostfixpassword  -e 'use postfixadmin'
#docker --tls=1 exec rowlandsio_mail_1 mysql -uroot -prootpassword  -e 'use postfixadmin'


#docker --tls=1 exec rowlandsio_mail_1 ls -lah /var/ | grep mail

docker --tls=1 exec rowlandsio_mail_1 chown 5000:5000 -R /var/mail



