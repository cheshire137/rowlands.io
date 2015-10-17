#!/bin/bash

source ./set-variables.sh

## Setup ovpn
#docker-compose --tls=1 up ovpn_data
#./vpn/generate-keys.sh
#./vpn/generate-client.sh
#./vpn/download-client.sh
#docker-compose --tls=1 up ovpn

# Setup mail
export DOCKER_CLIENT_TIMEOUT=120
export DOCKER_TLS_VERIFY=1
#docker-compose up -d mail_data
docker-compose -p rowlandsio up -d mail






