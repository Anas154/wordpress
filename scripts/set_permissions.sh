#!/bin/bash
echo "Setting ownership and permissions on /var/www/html..."
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

