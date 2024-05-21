#! /bin/bash

RESOURCE_GROUP_NAME='dump-radionica'
STORAGE_ACCOUNT_NAME='webstoragefordumpdays'
TEMPLATE='main.bicep'
INDEX_DOCUMENT='index.html'
ERROR_DOCUMENT='error.html'

# Deploy resources
az deployment group create --name storageAccountDeploy --resource-group $RESOURCE_GROUP_NAME --template-file $TEMPLATE --parameters parameters.json

# Enable the static website feature on the storage account.
az storage blob service-properties update --account-name $STORAGE_ACCOUNT_NAME --static-website --404-document $ERROR_DOCUMENT --index-document $INDEX_DOCUMENT

# # Add the two HTML pages.
az storage blob upload-batch --destination '$web' --source "../src" --account-name $STORAGE_ACCOUNT_NAME --content-type text/html --pattern '*.html' --overwrite true


