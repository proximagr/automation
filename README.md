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

## File: **[addDatabricksRoutes.ps1](https://github.com/proximagr/automation/blob/master/DatabricksRoutes/addDatabricksRoutes.ps1)** ##

Description: Create all required Routes for Databricks when deployed at your oen network (VNet). More info at: https://docs.microsoft.com/en-us/azure/databricks/administration-guide/cloud-configurations/azure/udr
Template csv with all West & North Europe required IPs: https://github.com/proximagr/automation/blob/master/DatabricksRoutes/routes.csv

Blog Post: [https://www.cloudcorner.gr/microsoft/azure/azure-databricks-with-existing-dns-azure-networks-on-premises-network/](https://www.cloudcorner.gr/microsoft/azure/azure-databricks-with-existing-dns-azure-networks-on-premises-network/)

## Policy: **[Audit - Enable Network Policy for Private Endpoints Blog Post](https://www.cloudcorner.gr/microsoft/azure/azure-policy-to-enable-network-policies-for-private-endpoints/)** ##

Get the Policy Json files: **[Audit privateEndpointNetworkPolicies](https://github.com/proximagr/automation/blob/master/Policies/audit%20privateEndpointNetworkPolicies.json)**
**[Enable privateEndpointNetworkPolicies](https://github.com/proximagr/automation/blob/master/Policies/privateEndpointNetworkPolicies.json)**

Description: Create multiple VNETs

## File: **[CreateMultipleVNETs.ps1](https://github.com/proximagr/automation/blob/master/CreateMultipleVNETs.ps1)** ##