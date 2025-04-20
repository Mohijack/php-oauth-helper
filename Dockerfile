FROM php:8.2-apache

# Aktiviere Apache-Module
RUN a2enmod rewrite

# Stelle sicher, dass index.php als DirectoryIndex verwendet wird
RUN echo "DirectoryIndex index.php index.html" > /etc/apache2/conf-available/directoryindex.conf \
    && a2enconf directoryindex

# Füge eine sichere, lesbare Apache-Konfiguration hinzu
RUN echo '<Directory /var/www/html>\n\
    Options Indexes FollowSymLinks\n\
    AllowOverride All\n\
    Require all granted\n\
</Directory>' > /etc/apache2/conf-available/custom-permissions.conf \
    && a2enconf custom-permissions

# Setze Arbeitsverzeichnis
WORKDIR /var/www/html

# Kopiere App-Dateien
COPY app/ /var/www/html/

# Setze Dateiberechtigungen
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
