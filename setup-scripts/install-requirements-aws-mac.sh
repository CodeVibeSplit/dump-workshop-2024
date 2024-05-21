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

# Check if Node.js is already installed and its version
if command -v node &> /dev/null; then
    CURRENT_NODE_VERSION=$(node -v)
    echo "Node.js is already installed. Current version: $CURRENT_NODE_VERSION"
    if [[ $CURRENT_NODE_VERSION == v18* ]]; then
        echo "Node.js version 18 is already installed."
    else
        # Install specific version of Node.js (Node 18) using Homebrew
        echo "A different version of Node.js is installed. Installing Node.js version 18..."
        brew install node@18

        # Add Node 18 to PATH if not already present
        if ! grep -q '/usr/local/opt/node@18/bin' "$PROFILE_FILE"; then
            echo 'export PATH="/usr/local/opt/node@18/bin:$PATH"' >> "$PROFILE_FILE"
            echo 'Node 18 PATH added to profile.'
        else
            echo 'Node 18 PATH already present in profile.'
        fi

        # Source the profile to update the PATH in the current session
        source "$PROFILE_FILE"
    fi
else
    echo "Node.js is not installed. Installing Node.js version 18..."
    brew install node@18
    # Add Node 18 to PATH if not already present
    if ! grep -q '/usr/local/opt/node@18/bin' "$PROFILE_FILE"; then
        echo 'export PATH="/usr/local/opt/node@18/bin:$PATH"' >> "$PROFILE_FILE"
        echo 'Node 18 PATH added to profile.'
    else
        echo 'Node 18 PATH already present in profile.'
    fi

    # Source the profile to update the PATH in the current session
    source "$PROFILE_FILE"

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
    brew install awscli
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
npm install -g aws-cdk || { echo "Failed to install AWS CDK"; exit 1; }

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
