#!/bin/bash

#docker --tls=$DOCKER_TLS run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENTNAME nopass
#docker --tls=$DOCKER_TLS run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENTNAME nopass

docker --tls=$DOCKER_TLS run --volumes-from $OVPN_DATA --rm -it jgrowl/mail opendkim-genkey -t -s mail -d $HOST
