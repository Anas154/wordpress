#!/bin/bash

# Exit on error
set -e

# Install AWS CLI (if not already installed)
if ! command -v aws &> /dev/null; then
  echo "Installing AWS CLI..."
  sudo apt-get update
  sudo apt-get install -y unzip curl
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip awscliv2.zip
  sudo ./aws/install
  echo "AWS CLI installed."
else
  echo "AWS CLI already installed."
fi

# Set variables from SSM
echo "Fetching DB parameters from AWS SSM..."
DB_NAME=$(aws ssm get-parameter --name "/wordpress/db_name" --query "Parameter.Value" --output text)
DB_USER=$(aws ssm get-parameter --name "/wordpress/db_user" --query "Parameter.Value" --output text)
DB_PASS=$(aws ssm get-parameter --name "/wordpress/db_pass" --with-decryption --query "Parameter.Value" --output text)
DB_HOST=$(aws ssm get-parameter --name "/wordpress/db_host" --query "Parameter.Value" --output text)

# Define path to wp-config.php
WP_CONFIG="/var/www/html/wp-config-sample.php"

# Inject values into wp-config.php
if [ -f "$WP_CONFIG" ]; then
  echo "Updating wp-config.php with DB parameters..."
  sudo sed -i "s/define( *'DB_NAME'.*/define( 'DB_NAME', '$DB_NAME' );/" $WP_CONFIG
  sudo sed -i "s/define( *'DB_USER'.*/define( 'DB_USER', '$DB_USER' );/" $WP_CONFIG
  sudo sed -i "s/define( *'DB_PASSWORD'.*/define( 'DB_PASSWORD', '$DB_PASS' );/" $WP_CONFIG
  sudo sed -i "s/define( *'DB_HOST'.*/define( 'DB_HOST', '$DB_HOST' );/" $WP_CONFIG
  echo "wp-config.php updated successfully."
else
  echo "wp-config.php not found at $WP_CONFIG"
  exit 1
fi

