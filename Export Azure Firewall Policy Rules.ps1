#Provide Input. Firewall Policy Name, Firewall Policy Resource Group & Firewall Policy Rule Collection Group Name
$fpname = "azfwpolicy"
$fprg = "azurehub"
$fprcgname = "DefaultNetworkRuleCollectionGroup"

$fp = Get-AzFirewallPolicy -Name $fpname -ResourceGroupName $fprg
$rcg = Get-AzFirewallPolicyRuleCollectionGroup -Name $fprcgname -AzureFirewallPolicy $fp

$returnObj = @()
foreach ($rulecol in $rcg.Properties.RuleCollection) {

foreach ($rule in $rulecol.rules)
{
$properties = [ordered]@{
    RuleCollectionName = $rulecol.Name;
    RulePriority = $rulecol.Priority;
    ActionType = $rulecol.Action.Type;
    RUleConnectionType = $rulecol.RuleCollectionType;
    Name = $rule.Name;
    protocols = $rule.protocols -join ", ";
    SourceAddresses = $rule.SourceAddresses -join ", ";
    DestinationAddresses = $rule.DestinationAddresses -join ", ";
    SourceIPGroups = $rule.SourceIPGroups -join ", ";
    DestinationIPGroups = $rule.DestinationIPGroups -join ", ";
    DestinationPorts = $rule.DestinationPorts -join ", ";
    DestinationFQDNs = $rule.DestinationFQDNs -join ", ";
}
$obj = New-Object psobject -Property $properties
$returnObj += $obj
}

#change c:\temp to the path to export the CSV
$returnObj | Export-Csv c:\temp\rules.csv -NoTypeInformation
}

