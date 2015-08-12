#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service courier-ssl stop; }" EXIT

# start postfix
/usr/sbin/service courier-imap-ssl start

# don't exit
sleep infinity