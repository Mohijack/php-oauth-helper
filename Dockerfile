# Nutze offizielles PHP + Apache Image
FROM php:8.2-apache

# Aktiviere Apache Rewrite-Modul (optional, für bessere URL-Weiterleitungen)
RUN a2enmod rewrite

# Setze Apache DirectoryIndex auf index.php (nicht nur index.html)
RUN echo "DirectoryIndex index.php index.html" > /etc/apache2/conf-available/directoryindex.conf \
    && a2enconf directoryindex

# Setze Arbeitsverzeichnis
WORKDIR /var/www/html

# Kopiere deine App-Dateien ins Apache-Verzeichnis
COPY app/ /var/www/html/

# Setze Berechtigungen (sicherstellen, dass Apache lesen darf)
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Offenlegung des Ports (Apache Standard)
EXPOSE 80
