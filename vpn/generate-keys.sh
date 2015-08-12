#!/bin/bash

#docker-compose --tls=$DOCKER_TLS run ovpn kylemanna/openvpn ovpn_genconfig -u udp://$VPN_URL
#docker-compose --tls=$DOCKER_TLS run ovpn -it kylemanna/openvpn ovpn_initpki


docker --tls=$DOCKER_TLS run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_genconfig -u udp://$VPN_URL
docker --tls=$DOCKER_TLS run --volumes-from $OVPN_DATA --rm -it kylemanna/openvpn ovpn_initpki
