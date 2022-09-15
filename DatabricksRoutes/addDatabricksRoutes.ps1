$location = 'westeurope'
$routeTableRGName = 'asktestvnet'
$vnetRGName = 'asktestvnet'
$vnetName = 'aksvnet'
$subnetName = 'akssubnet'
$routeTableName = 'myroutetable'
$dataBricksRouteName = 'DatabricksRoute'
$i = 1


# Create or Get Azure Route Table
$routeTable = New-AzRouteTable -ResourceGroupName $routeTableRGName -Location $location -Name $routeTableName
#$routeTable = Get-AzRouteTable -ResourceGroupName $routeTableRGName -Name $routeTableName

# Create Routes
$routes = import-csv 'C:\Users\papostolidis\OneDrive - eapostolidis\VSCODE\Databricks Routes\routes.csv'
foreach ($route in $routes)
    {
        Add-AzRouteConfig -Name "$($dataBricksRouteName)-$($i)" -AddressPrefix $route.route -RouteTable $routeTable -NextHopType internet
        $i = $i+1
    }

# Commit the changes
Set-AzRouteTable -RouteTable $routeTable

# Associate the Route Table with Subnets
$vnet = Get-AzVirtualNetwork -ResourceGroupName $vnetRGName -Name $vnetName
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -AddressPrefix '10.0.0.0/23' -RouteTable $routeTable

# Commit the changes
Set-AzVirtualNetwork -VirtualNetwork $vnet