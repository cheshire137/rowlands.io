#!/bin/bash
set -e

echo "Configuring mail..."
ansible-playbook /etc/ansible/main.yml -i localhost, --connection=local
