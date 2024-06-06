#!/bin/bash

# Create .htpasswd file with username and password from environment variables
htdigest -c /etc/apache2/.htpasswd webdav "$WEBDAV_USERNAME" <<< "$WEBDAV_PASSWORD"

# Start Apache service
apachectl -D FOREGROUND
