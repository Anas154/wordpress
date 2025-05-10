#!/bin/bash

echo "Checking for default index.html..."

if [ -f /var/www/html/index.html ]; then
    echo "Removing default Apache index.html"
    rm /var/www/html/index.html
else
    echo "No default index.html found, skipping."
fi

