$location = "Germany West Central"
$resourceGroupName = "myresourcegroup"
$virtualNetworkCount = 3

az group create --name $resourceGroupName --location $location

foreach ($virtualNetwork in 1..$($virtualNetworkCount)){
    az network vnet create `
    --name "vnet-$($virtualNetwork)" `
    --resource-group $resourceGroupName `
    --address-prefixes $("192.168.$($virtualNetwork).0/24") `
    --location $location `
    --subnet-name "default" `
    --subnet-prefixes $("192.168.$($virtualNetwork).0/24")  `
    --tags "env=test"
}