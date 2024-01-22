#!/bin/sh

if [ -z "$(ls -A /app)" ]; then
  cp -r /config/. /app
fi

sleep infinity