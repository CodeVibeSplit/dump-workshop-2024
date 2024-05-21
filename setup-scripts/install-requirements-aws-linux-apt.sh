#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Check if apt is available
if ! command -v apt &> /dev/null; then
    echo "APT package manager not found. This script is designed for Ubuntu."
    exit 1
fi

# Determine the shell profile file to use
if [ -n "$ZSH_VERSION" ]; then
    PROFILE_FILE=~/.zshrc
elif [ -n "$BASH_VERSION" ]; then
    PROFILE_FILE=~/.bashrc
else
    echo "Unsupported shell. Please manually add the PATH to your shell profile."
    exit 1
fi

# Update package lists and upgrade system packages
echo "Updating package lists and upgrading system packages..."
sudo apt update
sudo apt upgrade -y

# Check if curl is installed
if ! command -v curl &> /dev/null; then
    echo "curl not found. Installing curl..."
    sudo apt install -y curl
fi

# Check if Node.js is already installed and its version
if command -v node &> /dev/null; then
    CURRENT_NODE_VERSION=$(node -v)
    echo "Node.js is already installed. Current version: $CURRENT_NODE_VERSION"
    if [[ $CURRENT_NODE_VERSION == v18* ]]; then
        echo "Node.js version 18 is already installed."
    else
        # Install specific version of Node.js (Node 18) using NodeSource repository
        echo "A different version of Node.js is installed. Installing Node.js version 18..."
        curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
        sudo apt install -y nodejs

        # Add Node 18 to PATH if not already present
        if ! grep -q '/usr/bin/node' "$PROFILE_FILE"; then
            echo 'export PATH="/usr/bin:$PATH"' >> "$PROFILE_FILE"
            echo 'Node 18 PATH added to profile.'
        else
            echo 'Node 18 PATH already present in profile.'
        fi
    fi
else
    echo "Node.js is not installed. Installing Node.js version 18..."
    curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
    sudo apt install -y nodejs
    # Add Node 18 to PATH if not already present
    if ! grep -q '/usr/bin/node' "$PROFILE_FILE"; then
        echo 'export PATH="/usr/bin:$PATH"' >> "$PROFILE_FILE"
        echo 'Node 18 PATH added to profile.'
    else
        echo 'Node 18 PATH already present in profile.'
    fi
fi

# Verify installation
echo "Verifying Node.js installation..."
if command -v node &> /dev/null; then
    echo "Node.js successfully installed. Version: $(node -v)"
else
    echo "Node.js installation failed."
    exit 1
fi

if command -v npm &> /dev/null; then
    echo "npm successfully installed. Version: $(npm -v)"
else
    echo "npm installation failed."
    exit 1
fi

# Check if AWS CLI is already installed
if command -v aws &> /dev/null; then
    echo "AWS CLI is already installed. Version: $(aws --version)"
else
    echo "AWS CLI not found. Installing AWS CLI..."
    sudo apt install -y awscli
fi

# Verify AWS CLI installation
echo "Verifying AWS CLI installation..."
if command -v aws &> /dev/null; then
    echo "AWS CLI successfully installed. Version: $(aws --version)"
else
    echo "AWS CLI installation failed."
    exit 1
fi

# Install AWS CDK
echo "Installing AWS CDK..."
sudo npm install -g aws-cdk@latest || { echo "Failed to install AWS CDK"; exit 1; }

# Check if CDK is installed
echo "Checking if AWS CDK is installed..."
if npm list -g aws-cdk &> /dev/null; then
    echo "AWS CDK is installed."
else
    echo "AWS CDK installation failed."
    exit 1
fi

# Set AWS CLI default region
echo "Setting AWS CLI default region to eu-west-1..."
aws configure set region eu-west-1 || { echo "Failed to set AWS CLI default region"; exit 1; }
echo "AWS CLI default region set to eu-west-1."

# Set AWS CLI output format to JSON
echo "Setting AWS CLI output format to JSON..."
aws configure set output json || { echo "Failed to set AWS CLI output format"; exit 1; }
echo "AWS CLI output format set to JSON."