$location = ''
$routeTableRGName = ''
$routeTable = ''
$vnetRGName = ''
$vnetName = ''
$subnetName = ''
$subnetAddressPfx = ''
$routeTableName = ''
$dataBricksRouteName = ''
$routesPath = 'C:\...\routes.csv'
$i = 1


# Create or Get Azure Route Table
if ($routeTable = $null) {
    $routeTable = New-AzRouteTable -ResourceGroupName $routeTableRGName -Location $location -Name $routeTableName
    } else {
        $routeTable = Get-AzRouteTable -ResourceGroupName $routeTableRGName -Name $routeTableName
    }

# Create Routes
$routes = import-csv $routesPath
foreach ($route in $routes)
    {
        Add-AzRouteConfig -Name "$($dataBricksRouteName)-$($i)" -AddressPrefix $route.route -RouteTable $routeTable -NextHopType internet
        $i = $i+1
    }

# Commit the changes
Set-AzRouteTable -RouteTable $routeTable

# Associate the Route Table with Subnets
$vnet = Get-AzVirtualNetwork -ResourceGroupName $vnetRGName -Name $vnetName
Set-AzVirtualNetworkSubnetConfig -VirtualNetwork $vnet -Name $subnetName -AddressPrefix $subnetAddressPfx -RouteTable $routeTable

# Commit the changes
Set-AzVirtualNetwork -VirtualNetwork $vnet