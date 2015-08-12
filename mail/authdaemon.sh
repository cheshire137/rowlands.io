#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service courier-authdaemon stop; }" EXIT

# start postfix
/usr/sbin/service courier-authdaemon start

# don't exit
sleep infinity