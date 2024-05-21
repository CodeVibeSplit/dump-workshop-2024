# dump-workshop-2024

## Summary

This repository contains deploy for static web page to Azure/AWS

Example resources are deployed and available:

- AWS static page: https://d3fy29ux8ms6gv.cloudfront.net/
- Azure static page: https://webstoragefordumpdays1.z6.web.core.windows.net/

## Deploy resources

To deploy resources you can follow the steps described in readme files:

- [AWS](./deploy-aws/README.md)
- [Azure](./deploy-azure/README.md)

Both readme files have a section regarding the requirements needed to deploy the resources.
For Installing the requirements you can either follow the guides provided in their respective files or you can use the installation scripts provided:

#### AWS requirements installation
    Windows: ./setup-scripts/install-requirements-aws-windows.ps1
    Linux: ./setup-scripts/install-requirements-aws-linux-apt.sh or ./setup-scripts/install-requirements-aws-linux-yum.sh
    Mac: ./setup-scripts/install-requirements-aws-mac.sh
    
#### Azure requirements installation
    Windows: ./setup-scripts/install-requirements-azure-windows.ps1
    Linux: ./setup-scripts/install-requirements-azure-linux-apt.sh or ./setup-scripts/install-requirements-azure-linux-yum.sh
    Mac: ./setup-scripts/install-requirements-azure-mac.sh