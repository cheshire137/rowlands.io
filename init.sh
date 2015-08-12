#!/bin/bash

source ./set-variables.sh

## Setup ovpn
#docker-compose --tls=1 up ovpn_data
#./vpn/generate-keys.sh
#./vpn/generate-client.sh
#./vpn/download-client.sh
#docker-compose --tls=1 up ovpn

# Setup mail
docker-compose --tls=1 up mail_data
docker-compose --tls=1 up -d mail






