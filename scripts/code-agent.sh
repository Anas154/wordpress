#!/bin/bash

# Update system packages
sudo apt update -y

# Install required dependencies
sudo apt install ruby-full wget -y

# Move to a working directory
cd /home/ubuntu

# Download the CodeDeploy agent install script
wget https://aws-codedeploy-us-east-1.s3.us-east-1.amazonaws.com/latest/install

# Make the script executable
chmod +x ./install

# Run the installer
sudo ./install auto

# Start and enable the CodeDeploy agent
sudo systemctl start codedeploy-agent
sudo systemctl enable codedeploy-agent

# Restart the CodeDeploy agent to ensure it's fresh
sudo systemctl restart codedeploy-agent

# Show status to confirm it is running
sudo systemctl status codedeploy-agent

# Reboot the instance
sudo reboot

