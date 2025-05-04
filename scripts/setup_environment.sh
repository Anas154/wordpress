#!/bin/bash
echo "Updating packages and installing Apache & PHP..."
apt update -y
apt install -y apache2 php php-mysql libapache2-mod-php php-cli php-curl php-xml php-mbstring unzip
systemctl enable apache2
systemctl start apache2

