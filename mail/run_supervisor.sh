#!/bin/bash
set -e

supervisord -n -c /etc/supervisor/supervisord.conf

