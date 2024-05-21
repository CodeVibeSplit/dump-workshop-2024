# deploy-azure

## Summary

This repository contains code needed to deploy static web page to Azure using Bicep and PowerShell/Azure CLI scripts.

Microsoft documentation:

- [Bicep](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)
- [Host a static website in Azure Storage](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blob-static-website-how-to?tabs=azure-cli)
- [Azure PowerShell Documentation](https://learn.microsoft.com/en-us/powershell/azure/?view=azps-11.5.0)

## How to run

For deploying resources you can use either PowerShell or Azure CLI (bash scripts).

### Prepare your machine

1. **Install VS Code extensions:** Bicep, PowerShell (if you're going to use it - for Mac/Linux you will also need to install PS to machine)
2. **Install Azure CLI**

- For mac: `brew install azure-cli`, `az —version`
- For others check: [Install Azure CLI](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install))

3. **Install Bicep**

- `az bicep install`
- `az bicep version`

* **To use PowerShell scripts you will need to install Bicep CLI manually**:
  - For mac: `brew tap azure/bicep`, `brew install bicep`
  - For others check: [Install manually](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/install)
  - Install module: `Install-Module -Name Bicep`
  - Connect to AZ account: `Connect-AzAccount`

4. **Login to your Azure account:**

- `az login`

- `az login --service-principal --username ${appId} --password ${secret} --tenant ${tenantId}`
  NOTE: appId, secret and tenantId will be provided

### Create user credentials for login:

- `az login`
- Check for targeted subscriptionId: `az account list --output table`
- `az ad sp create-for-rbac` -> results: appId, displayName, password, tenant
- `az role assignment create --assignee ${appId} --role Contributor --scope /subscriptions/${subscriptionId}`

**Login:**

- `az login --service-principal --username ${appId} --password ${secret} --tenant ${tenantId}`

### Deploy resources

- Execute `deploy_resouce_group.ps1` or `deploy_resouce_group.sh` to create resource group (IF IT DOESN'T EXIST ALREADY) for your resources
- Execute `deploy_web.ps1` or `deploy_web.sh` to create storage account with static web page
