$Location = 'westeurope'
$TemplateFile = 'resourceGroup.bicep'

New-AzSubscriptionDeployment -Name 'resourceGroupDeploy' -Location $Location -TemplateFile $TemplateFile
