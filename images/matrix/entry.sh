#!/usr/bin/env sh
set -e

echo "Configuring matrix..."
ansible-playbook  /etc/ansible/main.yml -i localhost, --connection=local

SYNAPSE_CONFIG_DIR=/etc/synapse
python -m synapse.app.homeserver --config-path $SYNAPSE_CONFIG_DIR/homeserver.yaml
