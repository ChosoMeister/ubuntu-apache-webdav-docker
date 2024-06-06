# Base image
FROM ubuntu:20.04

# Install Apache and necessary modules
RUN apt-get update && \
    apt-get install -y apache2 apache2-utils && \
    a2enmod dav dav_fs dav_lock && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration and entrypoint script
COPY webdav.conf /etc/apache2/sites-available/webdav.conf
RUN ln -s /etc/apache2/sites-available/webdav.conf /etc/apache2/sites-enabled/webdav.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint and default command
ENTRYPOINT ["/entrypoint.sh"]
CMD ["apache2ctl", "-D", "FOREGROUND"]
