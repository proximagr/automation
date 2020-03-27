#This script checks all containers of an Azure storage account. At each conteiner if
#a blob with a spesific extension is missing then it deletes all bllobs in that container

# Suppress Warnings
Set-Item Env:\SuppressAzurePowerShellBreakingChangeWarnings "true"

# Storage account details
$storage_account_name = "...................." 
$storage_account_key = "........................"


## Creating Storage context for Source, destination and log storage accounts
$context = New-AzStorageContext -StorageAccountName $storage_account_name -StorageAccountKey $storage_account_key

$containers = Get-AzStorageContainer -Context $context

foreach($container in $containers)
{
$lock = Get-AzStorageBlob -Container $container.Name -Context $context -Blob *.lock
if (!$lock) { Get-AzStorageBlob -Container $container.Name -Context $context | Remove-AzStorageBlob -Force }
}
