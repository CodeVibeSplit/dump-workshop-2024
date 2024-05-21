targetScope = 'subscription'

@description('The name of the resource group to store resources.')
param resourceGroupName string = 'dump-radionica'

@description('The location into which the resources group should be deployed.')
param resourceGroupLocation string = 'westeurope'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}
