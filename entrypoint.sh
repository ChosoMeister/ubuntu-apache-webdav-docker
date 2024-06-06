#!/bin/bash
set -e

# Create password file if not exists
if [ ! -f /etc/apache2/webdav.password ]; then
    htpasswd -cb /etc/apache2/webdav.password "$WEBDAV_USERNAME" "$WEBDAV_PASSWORD"
fi

# Start Apache in the foreground
exec "$@"
