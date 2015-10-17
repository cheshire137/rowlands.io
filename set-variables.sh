#!/bin/bash

export DOCKER_CERT_PATH=/home/jgrowlands/.sdc/docker/jgrowl # Sets the source location of the certs. Path must be absolute
export DOCKER_HOST=tcp://us-east-1.docker.joyent.com:2376
export DOCKER_TLS=1
export DOCKER_TLS_VERIFY=1

#export DOCKER_CERT_PATH=/home/jgrowlands/.joyent # Sets the source location of the certs. Path must be absolute
#export DOCKER_HOST_IP=165.225.167.59
#export DOCKER_HOST_PORT=4243
#export DOCKER_HOST=tcp://$DOCKER_HOST_IP:$DOCKER_HOST_PORT
#unset DOCKER_TLS_VERIFY
#export DOCKER_TLS=1

#export OVPN_DATA="ovpn-data"
export VPN_URL=VPN.ROWLANDS.IO
export CLIENTNAME=vpn.rowlands.io

export COMPOSE_PROJECT_NAME=rowlandsio
export OVPN_DATA=$COMPOSE_PROJECT_NAME"_ovpn_data_1"
