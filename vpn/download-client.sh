#!/bin/bash

docker --tls=$DOCKER_TLS run --volumes-from $OVPN_DATA --rm kylemanna/openvpn ovpn_getclient $CLIENTNAME > "$CLIENTNAME.ovpn"
