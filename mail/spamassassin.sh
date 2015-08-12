#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service spamassassin stop; }" EXIT

# start postfix
/usr/sbin/service spamassassin start

# don't exit
sleep infinity