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
sudo yum check-update

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "Azure CLI not found. Installing Azure CLI..."
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
    sudo yum install -y azure-cli
else
    echo "Azure CLI is already installed."
fi

# Check if PowerShell is installed
if ! command -v pwsh &> /dev/null; then
    echo "PowerShell not found. Installing PowerShell..."
    # Import the public repository GPG keys
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

    # Add the PowerShell repository
    sudo sh -c 'echo -e "[powershell]\nname=PowerShell\nbaseurl=https://packages.microsoft.com/yumrepos/microsoft-rhel7.3-prod\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/microsoft.repo'

    # Install PowerShell
    sudo yum install -y powershell
else
    echo "PowerShell is already installed."
fi