#!/bin/bash
set -e

# Create password file if not exists
if [ ! -f /etc/apache2/webdav.password ]; then
    echo "$WEBDAV_USERNAME:$WEBDAV_PASSWORD" > /etc/apache2/webdav.password
fi

# Start Apache in the foreground
exec "$@"
