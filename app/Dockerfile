FROM wordpress:apache
WORKDIR /usr/src/wordpress

# Copy code from custom development
COPY custom-theme/ ./wp-content/themes/custom-theme/
COPY custom-plugin/ ./wp-content/plugins/custom-plugin/

# START APACHE
CMD ["apache2-foreground"]