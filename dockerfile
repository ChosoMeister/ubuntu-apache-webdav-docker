# Use the official Ubuntu base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    apache2 \
    apache2-utils \
    libapache2-mod-authnz-external \
    libapache2-mod-security2 \
    davfs2 \
    && rm -rf /var/lib/apt/lists/*

# Enable required Apache modules
RUN a2enmod dav \
    dav_fs \
    dav_lock \
    auth_digest \
    authz_user \
    authz_groupfile

# Create WebDAV directory and set permissions
RUN mkdir -p /var/www/webdav \
    && chown -R www-data:www-data /var/www/webdav

# Copy the WebDAV configuration file
COPY ./webdav.conf /etc/apache2/sites-available/webdav.conf

# Copy the entrypoint script
COPY ./entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Enable the WebDAV site
RUN a2ensite webdav \
    && a2dissite 000-default

# Expose ports
EXPOSE 80

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
