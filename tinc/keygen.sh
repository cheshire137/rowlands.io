#!/usr/bin/env sh
set -e

TINC_KEY_BITS=2048

mkdir -p /etc/tinc/
echo "Generating public/private tinc keys..."
echo "\n\n" | tincd -K $(TINC_KEY_BITS)

# Assuming the default locations are used. New version of tinc will allow non-interactive key creation
cat /etc/tinc/rsa_key.priv
cat /etc/tinc/rsa_key.pub
