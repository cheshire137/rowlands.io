#!/usr/bin/env sh
set -e

echo "Configuring dns..."
ansible-playbook  /etc/ansible/main.yml -i localhost, --connection=local


echo "Starting in 10 seconds..."
sleep 15

exec /usr/sbin/pdns_server --daemon=no --guardian=no --control-console --loglevel=9
