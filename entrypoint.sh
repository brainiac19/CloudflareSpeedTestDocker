#!/bin/sh

if [ -z "$(ls -A /app)" ]; then
  cd  /config
  cp  CloudflareST ip.txt ipv6.txt /app
fi

export PATH="/app:$PATH"
cd /app
sleep infinity