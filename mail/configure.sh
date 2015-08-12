#!/bin/bash

#docker --tls=1 exec rowlandsio_mail_1 debconf-show postfixadmin

SETUP_PASSWORD_HASH=ee0adaf9a996c9b91d0f9ce222ac57fd:b2149bc5be83c607ad100ebade7cd49b9d50570e
./postfixadmin-conf.sh setup_password $SETUP_PASSWORD_HASH

DATABASE_TYPE=mysqli
./postfixadmin-conf.sh database_type $DATABASE_TYPE

#DATABASE_PASSWORD=Kn6EOtvTPzsptXuwiTPTz7fUpKJrGHfjKffw
DATABASE_PASSWORD=postfixpassword
./postfixadmin-conf.sh database_password $DATABASE_PASSWORD


#ENCRYPT=mysql_encrypt
#./postfixadmin-conf.sh 'encrypt' $ENCRYPT


###DATABASE_NAME=postfixadmin
###./postfixadmin-conf.sh database_name $DATABASE_NAME
#
#./postfixadmin-cf-conf.sh password $DATABASE_PASSWORD


docker --tls=1 exec rowlandsio_mail_1 mysql -uroot -prootpassword  -e "SET PASSWORD FOR 'postfixadmin'@'localhost' = PASSWORD('$DATABASE_PASSWORD');"

#DATABASE_ADMIN_PASSWORD=postfixadminpassword
#docker --tls=1 exec -t rowlandsio_mail_1 bash -c 'debconf-show postfixadmin echo "set postfixadmin/mysql/admin-pass $DATABASE_ADMIN_PASSWORD" | debconf-communicate'
#docker --tls=1 exec -t rowlandsio_mail_1 bash -c 'debconf-show postfixadmin echo "set postfixadmin/mysql/app-pass $DATABASE_PASSWORD" | debconf-communicate'

# Make sure /var/mail is chowned to avoid permission problems.
docker --tls=1 exec rowlandsio_mail_1 chown 5000:5000 -R /var/mail

#TODO update password in smtpd.conf and authmysqlrc
