#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service postgrey stop; }" EXIT

# start postfix
/usr/sbin/service postgrey start

# don't exit
sleep infinity