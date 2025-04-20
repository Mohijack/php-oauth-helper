# Verwende offizielles PHP + Apache Image
FROM php:8.2-apache

# Aktiviere Apache Rewrite-Modul (optional, je nach Setup)
RUN a2enmod rewrite

# Setze Arbeitsverzeichnis
WORKDIR /var/www/html

# Kopiere deine App in den Container
COPY app/ /var/www/html/

# Setze Dateiberechtigungen (optional)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

EXPOSE 80
