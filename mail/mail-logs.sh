#!/bin/bash

docker --tls=1 exec rowlandsio_mail_1 tail /var/log/mail.log

