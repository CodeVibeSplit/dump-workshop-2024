#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Check if Chocolatey is installed
if ! command -v choco &> /dev/null; then
    echo "Chocolatey not found. Installing Chocolatey..."
    # Installing Chocolatey requires administrative privileges, so we'll prompt for sudo
    if [ "$EUID" -ne 0 ]; then
        echo "This script requires administrative privileges to install Chocolatey."
        echo "Please run the script with sudo or as an administrator."
        exit 1
    fi
    # Install Chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
else
    echo "Chocolatey is already installed."
fi

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI not found. Installing AWS CLI..."
    choco install awscli -y
else
    echo "AWS CLI is already installed."
fi