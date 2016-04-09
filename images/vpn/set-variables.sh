#!/bin/bash

export DOCKER_CERT_PATH=/home/jgrowlands/.sdc/docker/jgrowl # Sets the source location of the certs. Path must be absolute
export DOCKER_HOST=tcp://us-east-1.docker.joyent.com:2376
export DOCKER_TLS=1
export DOCKER_TLS_VERIFY=1

#export DOCKER_CERT_PATH=/home/jgrowlands/.joyent # Sets the source location of the certs. Path must be absolute
#export DOCKER_HOST=tcp://72.2.115.165:4243
#unset DOCKER_TLS_VERIFY
#export DOCKER_TLS=1

export OVPN_DATA="ovpn-data"
export VPN_URL=VPN.ROWLANDS.IO

export CLIENTNAME=vpn.rowlands.io
