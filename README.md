# Αutomation Scripts

## File: **Add-DataDisks-DIffSize_v3.ps1** ##

Description: Adds multiple data disks to an Azure VM
 * Shows the disk capacity of the VM and asks how many disks to add.
 * Prompts for the size of every disk
 * Checks for empty Luns to add the disks

Blog Post: https://www.cloudcorner.gr/microsoft/azure/azure-vm-add-multiple-data-disks-v2/


## File: **CheckExtensionAndDeleteAllBlobs.ps1** ##

Description: This script checks all containers of an Azure storage account. At each conteiner if a blob with a spesific extension is missing then it deletes all bllobs in that container
