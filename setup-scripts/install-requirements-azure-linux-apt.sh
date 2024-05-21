#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Determine the shell profile file to use
if [ -n "$ZSH_VERSION" ]; then
    PROFILE_FILE=~/.zshrc
elif [ -n "$BASH_VERSION" ]; then
    PROFILE_FILE=~/.bash_profile
else
    echo "Unsupported shell. Please manually add the PATH to your shell profile."
    exit 1
fi

# Update the package list
echo "Updating package list..."
sudo apt update

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "Azure CLI not found. Installing Azure CLI..."
    curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
else
    echo "Azure CLI is already installed."
fi

# Check if PowerShell is installed
if ! command -v pwsh &> /dev/null; then
    echo "PowerShell not found. Installing PowerShell..."
    # Import the public repository GPG keys
    wget -q "https://packages.microsoft.com/keys/microsoft.asc" -O- | sudo apt-key add -

    # Register the Microsoft Ubuntu repository
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-focal-prod focal main" > /etc/apt/sources.list.d/microsoft.list'

    # Update the package list again after adding the new repository
    sudo apt update

    # Install PowerShell
    sudo apt install -y powershell
else
    echo "PowerShell is already installed."
fi