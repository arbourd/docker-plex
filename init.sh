#!/bin/bash

GROUPID=$(stat -c "%g" /plex)
GROUP_EXISTS=$(grep -c "${USERID}" < /etc/passwd)

# Set Plex user to host's group id
if [ "$GROUP_EXISTS" = "0" ]; then
  usermod -g "${GROUPID}" plex
else
  GROUPNAME=$(getent group "$GROUPID" | cut -d: -f1)
  usermod -a -G "$GROUPNAME" plex
fi

# Set plex home directory to `/plex` and change ownership
usermod -d /plex plex && chown -R plex: /plex

# Clear previous session
rm -f "/plex/Library/Application Support/Plex Media Server/plexmediaserver.pid"

# Run Plex as user `plex`
su plex -c /usr/sbin/start_pms
