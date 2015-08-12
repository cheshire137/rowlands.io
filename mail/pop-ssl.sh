#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service courier-pop-ssl stop; }" EXIT

# start postfix
/usr/sbin/service courier-pop-ssl start

# don't exit
sleep infinity