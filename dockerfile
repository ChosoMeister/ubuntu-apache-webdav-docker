FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y apache2 apache2-utils && \
    apt-get clean

RUN mkdir -p /var/www/html/media && \
    chown -R www-data:www-data /var/www/html/media && \
    a2enmod dav && \
    a2enmod dav_fs

COPY webdav.conf /etc/apache2/sites-available/000-default.conf

# Entrypoint script to generate password file
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
