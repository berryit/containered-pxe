#!/bin/bash

# Wrapper script for dnsmasq to ensure TFTP logs are visible in docker logs
echo "[dnsmasq] Starting TFTP server on port 69"
echo "[dnsmasq] TFTP root: /pxe_images"
echo "[dnsmasq] TFTP security: enabled"
echo "[dnsmasq] Logging: enabled (dhcp and queries)"

# Start dnsmasq as root to bind to port 69, then drop privileges to pxe
exec /usr/sbin/dnsmasq --port=0 --keep-in-foreground --enable-tftp --user=pxe --tftp-secure --tftp-root=/pxe_images --log-facility=- --log-dhcp --log-queries "$@"
