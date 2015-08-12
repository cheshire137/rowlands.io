#!/bin/bash

source ./set-variables.sh

HOST=rowlands.io
SUBDOMAIN=mail
CMD="(cd /etc/mail && opendkim-genkey -t -s $SUBDOMAIN -d $HOST && mv mail.private dkim.key)"
docker-compose --tls=1 run --rm  mail bash -c $CMD
docker-compose --tls=1 run --rm  mail bash -c "cat /etc/mail/mail.txt"






