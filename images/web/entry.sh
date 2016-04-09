#!/bin/bash
set -e

echo "Configuring web..."
ansible-playbook  /etc/ansible/main.yml -i localhost, --connection=local

if [ ! -e '/var/www/html/version.php' ]; then
	tar cf - --one-file-system -C /usr/src/owncloud . | tar xf -
	chown -R www-data /var/www/html
fi

exec "$@"
