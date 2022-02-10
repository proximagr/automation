$fp = Get-AzFirewallPolicy -Name azfwpolicy -ResourceGroupName azurehub
$rcg = Get-AzFirewallPolicyRuleCollectionGroup -Name DefaultNetworkRuleCollectionGroup -AzureFirewallPolicy $fp

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

$returnObj | Export-Csv c:\temp\rules.csv -NoTypeInformation
}

