#!/bin/bash

#docker --tls=1 exec rowlandsio_mail_1 ls -lh /var/log/apache2
docker --tls=1 exec rowlandsio_mail_1 tail /var/log/apache2/error.log

