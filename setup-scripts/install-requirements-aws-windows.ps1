# Check if Chocolatey is installed
if (!(Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Chocolatey not found. Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
} else {
    Write-Host "Chocolatey is already installed."
}

# Check if Node.js is installed and its version
if (!(Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "Node.js is not installed. Installing Node.js..."
    choco install nodejs
} else {
    $CURRENT_NODE_VERSION = node -v
    Write-Host "Node.js is already installed. Current version: $CURRENT_NODE_VERSION"
}

# Verify installation
Write-Host "Verifying Node.js installation..."
if (Get-Command node -ErrorAction SilentlyContinue) {
    Write-Host "Node.js successfully installed. Version: $(node -v)"
} else {
    Write-Host "Node.js installation failed."
    exit 1
}

if (Get-Command npm -ErrorAction SilentlyContinue) {
    Write-Host "npm successfully installed. Version: $(npm -v)"
} else {
    Write-Host "npm installation failed."
    exit 1
}

# Check if AWS CLI is already installed
if (!(Get-Command aws -ErrorAction SilentlyContinue)) {
    Write-Host "AWS CLI not found. Installing AWS CLI..."
    choco install awscli
} else {
    Write-Host "AWS CLI is already installed. Version: $(aws --version)"
}

# Verify AWS CLI installation
Write-Host "Verifying AWS CLI installation..."
if (Get-Command aws -ErrorAction SilentlyContinue) {
    Write-Host "AWS CLI successfully installed. Version: $(aws --version)"
} else {
    Write-Host "AWS CLI installation failed."
    exit 1
}

# Install AWS CDK
Write-Host "Installing AWS CDK..."
npm install -g aws-cdk
if ($?) {
    Write-Host "AWS CDK installed successfully."
} else {
    Write-Host "Failed to install AWS CDK."
    exit 1
}

# Set AWS CLI default region
Write-Host "Setting AWS CLI default region to eu-west-1..."
aws configure set region eu-west-1
if ($?) {
    Write-Host "AWS CLI default region set to eu-west-1."
} else {
    Write-Host "Failed to set AWS CLI default region."
    exit 1
}

# Set AWS CLI output format to JSON
Write-Host "Setting AWS CLI output format to JSON..."
aws configure set output json
if ($?) {
    Write-Host "AWS CLI output format set to JSON."
} else {
    Write-Host "Failed to set AWS CLI output format."
    exit 1
}