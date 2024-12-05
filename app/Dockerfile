FROM bitnami/wordpress:6
WORKDIR /bitnami/wordpress

# Copy code from custom development
COPY custom-theme/ ./wp-content/themes/custom-theme/
COPY custom-plugin/ ./wp-content/plugins/custom-plugin/

# START APACHE
CMD ["apache2-foreground"]