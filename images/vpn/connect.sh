#!/bin/bash
source set-variables.sh

sudo openvpn --config "$CLIENTNAME.ovpn" --remote 72.2.115.165

