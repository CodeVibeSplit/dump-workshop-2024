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

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew is already installed."
fi

# Ensure Homebrew is up-to-date
echo "Updating Homebrew..."
brew update

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo "Azure CLI not found. Installing Azure CLI..."
    brew install azure-cli
else
    echo "Azure CLI is already installed."
fi

# Check if Azure PowerShell is installed
if ! command -v pwsh &> /dev/null; then
    echo "Azure PowerShell not found. Installing Azure PowerShell..."
    brew install --cask powershell
else
    echo "Azure PowerShell is already installed."
fi