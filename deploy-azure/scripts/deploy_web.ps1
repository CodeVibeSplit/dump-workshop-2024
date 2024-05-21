$ResourceGroupName = 'dump-radionica'
$StorageAccountName = 'webstoragefordumpdays'
$Template = 'main.bicep'
$INDEX_DOCUMENT='index.html'
$ERROR_DOCUMENT='error.html'
$IndexDocumentPath = '../src/index.html'
$ErrorDocumentPath = '../src/error.html'

# Deploy resources
New-AzResourceGroupDeployment  -Name 'storageAccountDeploy' -ResourceGroupName $ResourceGroupName -TemplateFile $Template -TemplateParameterFile '.\parameters.json' -Verbose

$ErrorActionPreference = 'Stop'
$storageAccount = Get-AzStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName

# Enable the static website feature on the storage account.
$ctx = $storageAccount.Context
Enable-AzStorageStaticWebsite -Context $ctx -IndexDocument $INDEX_DOCUMENT -ErrorDocument404Path $ERROR_DOCUMENT

# # Add the two HTML pages.
Set-AzStorageBlobContent -Context $ctx -Container '$web' -File $IndexDocumentPath -Blob $INDEX_DOCUMENT -Properties @{'ContentType' = 'text/html' } -Force
Set-AzStorageBlobContent -Context $ctx -Container '$web' -File $ErrorDocumentPath -Blob $ERROR_DOCUMENT -Properties @{'ContentType' = 'text/html' } -Force
