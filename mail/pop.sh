#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service courier-pop stop; }" EXIT

# start postfix
/usr/sbin/service courier-pop start

# don't exit
sleep infinity