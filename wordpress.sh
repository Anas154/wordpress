#!/bin/bash

set -e  # Exit on error

# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# Fix broken or interrupted installations
sudo dpkg --configure -a

# Install Apache
sudo apt install apache2 -y

# Install PHP and required modules
sudo apt install php libapache2-mod-php php-mysql php-cli php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip -y

# Restart Apache
sudo systemctl restart apache2

# Download WordPress
curl -O https://wordpress.org/latest.tar.gz
tar xzvf latest.tar.gz

# Configure WordPress
cp -r wordpress /var/www/html
sudo rm -rf /var/www/html/index.html
sudo cp /var/www/html/wordpress/* /var/www/html/
sudo rm -rf /var/www/html/wordpress

# Set ownership and permissions
sudo chown -R www-data:www-data /var/www/html
sudo find /var/www/html/ -type d -exec chmod 755 {} \;
sudo find /var/www/html/ -type f -exec chmod 644 {} \;

# Restart Apache again
sudo systemctl restart apache2

echo "✅ WordPress files are set up. Open http://localhost to complete setup via browser."

