#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service opendkim stop; }" EXIT

/usr/sbin/service opendkim start

# don't exit
sleep infinity