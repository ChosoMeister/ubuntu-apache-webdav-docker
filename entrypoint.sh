#!/bin/bash

# Create password file with encrypted password
htpasswd -cb /etc/apache2/webdav.password $WEBDAV_USERNAME $WEBDAV_PASSWORD

# Start Apache in the foreground
apachectl -D FOREGROUND
