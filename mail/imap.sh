#!/usr/bin/env bash

# exit cleanly
trap "{ /usr/sbin/service courier-imap stop; }" EXIT

# start postfix
/usr/sbin/service courier-imap start

# don't exit
sleep infinity