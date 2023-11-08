#!/bin/bash

# Define parameters
# Standard_B1ls the smallest Linux vm size and Standard_B1s the smallest windows server vm size
# Ubuntu2204 the image to use and for the windows image use "MicrosoftWindowsServer:WindowsServer:2012-Datacenter:latest"
# and for Windows smalldisk use 2022-datacenter-azure-edition-smalldisk
resourceGroup="appservicedns"
location="swedencentral"
vmSize="Standard_D2s_v5"
vmNamePrefix="apsrvdns"
image="MicrosoftWindowsServer:WindowsServer:2022-datacenter-smalldisk:latest"
adminUsername="padmin"
adminPassword="MakaroniaMeKima!"
vnetName="appsrvd"
subnetName="vms"
vnetAddressPrefix="10.26.0.0/24"
subnetAddressPrefix="10.26.0.0/24"

#Create the resource group
az group create \
    -n $resourceGroup \
    -l $location

#Deploy the Virtual Network
az network vnet create \
    -n $vnetName \
    -g $resourceGroup \
    --address-prefix $vnetAddressPrefix \
    --subnet-name $subnetName \
    --subnet-prefixes $subnetAddressPrefix

# Deploy multiple VMs
az vm create \
    -n $vmNamePrefix \
    -g $resourceGroup \
    --image $image \
    --size $vmSize \
    --vnet-name $vnetName \
    --subnet $subnetName \
    --public-ip-address "" \
    --admin-username $adminUsername \
    --admin-password $adminPassword \
    --count 5

# to run the script first run chmod +x createVMs.sh and then ./createVMs.sh

# Enable boot diagnostics with managed storage account
# az vm boot-diagnostics enable --ids $(az vm list -g $resourceGroup --query "[].id" -o tsv)