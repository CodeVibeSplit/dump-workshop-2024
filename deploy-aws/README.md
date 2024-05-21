# deploy-aws

## Summary

This repository contains code needed to deploy static web page to AWS using aws-cdk and deployment script

AWS documentation:

- [Getting started with aws-cdk](https://docs.aws.amazon.com/cdk/v2/guide/getting_started.html)
- [Host a static website on S3 bucket using AWS-CDK](https://aws-cdk.com/deploying-a-static-website-using-s3-and-cloudfront)

## How to run

For deploying resources you will need to run yarn commands and bash scripts

### Prepare your machine

#### General pre-requisites

    Node 18+
    npm
    yarn (Optional)

#### AWS related

1. **Install latest version of AWS CLI**:
2. **Install VS Code extensions**: AWS Toolkit, TypeScript (Optional)

- For mac: `brew install awscli `
- For others check: [Getting started with aws-cdk](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)

3. **Install aws-cdk on global level**:

- Install: `npm install -g aws-cdk`
- Check does cdk exist: `npm list -g aws-cdk`
- Set region to eu-west-1, format -> json: `aws configure`

### Deploy resources

For Mac/Linux users: Navigate to deploy-aws folder and execute `deploy.sh`

        NOTE: If you are having issues with runing sh script
        1. Open terminal
        2. Type: chmod u+x ./scripts/deploy.sh
        3. Press Enter

For Windows users: Navigate to deploy-aws folder and execute `deploy.ps1`

        NOTE: If you are having issues with runing ps script
        1. Open PowerShell as an Administrator
        2. Type: Set-ExecutionPolicy Unrestricted
        3. Press Enter
        4. Type A
