#!/bin/bash

#docker --tls=1 exec rowlandsio_mail_1 tail /var/log/auth.log
docker --tls=1 exec rowlandsio_mail_1 cat /var/log/auth.log

