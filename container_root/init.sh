#!/bin/bash

# Configure user and group IDs
PUID=${PUID:-1000}
PGID=${PGID:-1000}

echo "[init] Setting up user pxe with PUID=${PUID} and PGID=${PGID}"

# Create group with specified GID if it doesn't exist
if ! getent group "${PGID}" > /dev/null 2>&1; then
    groupadd -g "${PGID}" pxe
else
    echo "[init] Group with GID ${PGID} already exists"
fi

# Create user with specified UID if it doesn't exist
if ! getent passwd "${PUID}" > /dev/null 2>&1; then
    useradd -u "${PUID}" -g "${PGID}" -d /pxe_images -s /bin/false pxe
else
    echo "[init] User with UID ${PUID} already exists"
fi

# Add to users group for compatibility
usermod -a -G users pxe 2>/dev/null || true

# make folders
mkdir -p \
  /pxe_configs \
  /pxe_images \
  /nginx_config/site-confs \
  /run \
  /var/lib/nginx/logs \
  /var/lib/nginx/tmp/client_body \
  /var/tmp/nginx \
  /var/log

# copy config files
[[ ! -f /nginx_config/nginx.conf ]] && \
  cp /defaults/nginx.conf /nginx_config/nginx.conf

# replace ${NGINX_PORT} during copy with the env variable value.
# shellcheck disable=SC2016
[[ ! -f /nginx_config/site-confs/default ]] && \
  envsubst '${NGINX_PORT}' < /defaults/default > /nginx_config/site-confs/default

# Set up permissions for all directories that services need to write to
chown -R pxe:pxe /pxe_configs
chown -R pxe:pxe /pxe_images
chown -R pxe:pxe /nginx_config
chown -R pxe:pxe /var/lib/nginx
chown -R pxe:pxe /run
chown -R pxe:pxe /var/tmp/nginx
chown -R pxe:pxe /var/log/nginx
