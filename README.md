# Αutomation Scripts

## File: **[Add-DataDisks-DIffSize_v3.ps1](https://github.com/proximagr/automation/blob/master/Add-DataDisks-DIffSize_v3.ps1)** ##

Description: Adds multiple data disks to an Azure VM
 * Shows the disk capacity of the VM and asks how many disks to add.
 * Prompts for the size of every disk
 * Checks for empty Luns to add the disks

Blog Post: https://www.cloudcorner.gr/microsoft/azure/azure-vm-add-multiple-data-disks-v2/


## File: **[CheckExtensionAndDeleteAllBlobs.ps1](https://github.com/proximagr/automation/blob/master/CheckExtensionAndDeleteAllBlobs.ps1)** ##

Description: This script checks all containers of an Azure storage account. At each conteiner if a blob with a spesific extension is missing then it deletes all bllobs in that container

## File: **[singleVmCPU.ps1](https://github.com/proximagr/automation/blob/master/singleVmCPU.ps1)** ##

Get the Average CPU percentage above a specific limit that you will specify for an Azure VM.

## File: **[multipleVmsCPU.ps1](https://github.com/proximagr/automation/blob/master/multipleVmsCPU.ps1)** ##

Get the Average CPU percentage above a specific limit that you will specify for a list of Azure VMs.
The list must be named "vmlist.csv" and must have two columns, one named "vmname" and one "resourcegroupname". 
You can download a sample vm list from here: **[vmlist.csv](https://github.com/proximagr/automation/blob/master/vmlist.csv)**

./multipleVmsCPU.ps1 > .\export.txt

## File: **[Export Azure Firewall Policy Rules.ps1](https://github.com/proximagr/automation/blob/master/Export%20Azure%20Firewall%20Policy%20Rules.ps1)** ##

Description: Exports all Rule Colections & Rules of an Azure Firewall Rule Collection Group in a CSV file. More info at: https://www.cloudcorner.gr/microsoft/azure/azure-firewall-policy-rules-to-csv/

## File: **[Import Azure Firewall Policy Rules.ps1](https://github.com/proximagr/automation/blob/master/Import%20Azure%20Firewall%20Policy%20Rules.ps1)** ##

Description: Imports all Rules from a CSV to a Rule Collection of an Azure Firewall Policy. More info at: https://www.cloudcorner.gr/microsoft/azure/azure-firewall-policy-rules-to-csv/
