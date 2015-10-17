#!/usr/bin/env sh
set -e

# Reduce maximum number of number of open file descriptors to 1024
# otherwise slapd consumes two orders of magnitude more of RAM
# see https://github.com/docker/docker/issues/8231
ulimit -n 1024

echo "Configuring ldap..."
ansible-playbook  /etc/ansible/main.yml -i localhost, --connection=local

echo "Starting in 10 seconds..."
sleep 10
export LDAP_LOG_LEVEL=256
#export LDAP_LOG_LEVEL=-1
exec /usr/sbin/slapd -h "ldap://$HOSTNAME ldaps://$HOSTNAME ldap://localhost ldaps://localhost ldapi:///" -u ldap -g ldap -d $LDAP_LOG_LEVEL
