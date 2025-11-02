#!/bin/bash

# Perform the initial configuration as root
/init.sh

echo
echo "+------------------------------------------------------------+"
echo "| █▀▀ █▀█ █▀█ ▀█▀ █▀█ ▀█▀ █▀█ █▀▀ █▀▄ █▀▀ █▀▄     █▀█ █ █ █▀▀|"
echo "| █   █ █ █ █  █  █▀█  █  █ █ █▀▀ █▀▄ █▀▀ █ █ ▄▄▄ █▀▀ ▄▀▄ █▀▀|"
echo "| ▀▀▀ ▀▀▀ ▀ ▀  ▀  ▀ ▀ ▀▀▀ ▀ ▀ ▀▀▀ ▀ ▀ ▀▀▀ ▀▀      ▀   ▀ ▀ ▀▀▀|"
echo "+------------------------------------------------------------+"
echo
echo "Source code: https://github.com/berryit/containered-pxe"
echo "Inspired by: https://github.com/netbootxyz/netboot.xyz"
echo

# Run supervisord as root
echo "[start] Starting supervisord (programs will run as pxe)"
exec supervisord -c /etc/supervisor.conf
