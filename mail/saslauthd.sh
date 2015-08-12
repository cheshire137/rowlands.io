#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service saslauthd stop; }" EXIT

/usr/sbin/service saslauthd start

# don't exit
sleep infinity