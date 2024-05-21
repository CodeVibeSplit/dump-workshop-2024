targetScope = 'resourceGroup'

@description('The name of the storage account to use for site hosting.')
param storageAccountName string = '_______-'

@description('The location into which the resources should be deployed.')
param location string = resourceGroup().location

@description('The storage account sku name.')
param storageSku string = 'Standard_LRS'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: '________'
  location: '________'
  sku: {
    name: '________'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: 'default'
  parent: '________'
}

resource webContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: '$web'
  parent: '________'
  properties: {
    publicAccess: 'Container'
  }
}

output accountName string = storageAccount.name
output deployedContainers string = webContainer.name
