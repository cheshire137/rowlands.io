#!/usr/bin/env sh
set -e

if [ "$1" = 'keygen' ]; then
    exec /usr/local/bin/keygen.sh
elif [ "$1" = 'sh' ]; then
    exec sh
else
    ansible-playbook /etc/ansible/main.yml -vvv -i localhost, --connection=local --extra-vars "$ANSIBLE_EXTRA_VARS"
    exec /usr/sbin/tincd $@
fi

