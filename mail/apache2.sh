#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service apache2 stop; }" EXIT

# start postfix
/usr/sbin/service apache2 start

# don't exit
sleep infinity