#Provide Input. Firewall Policy Name, Firewall Policy Resource Group & Firewall Policy Rule Collection Group Name
$fpname = azfwpolicy
$fprg = azurehub
$fprcgname = DefaultNetworkRuleCollectionGroup

$targetfp = Get-AzFirewallPolicy -Name $fpname -ResourceGroupName $fprg
$targetrcg = New-AzFirewallPolicyRuleCollectionGroup -Name $fprcgname -Priority 200 -FirewallPolicyObject $targetfp

$RulesfromCSV = @()
# Change the folder where the CSV is located
$readObj = import-csv C:\temp\rules.csv
foreach ($entry in $readObj)
{
    $properties = [ordered]@{
        RuleCollectionName = $entry.RuleCollectionName;
        RulePriority = $entry.RulePriority;
        ActionType = $entry.ActionType;
        Name = $entry.Name;
        protocols = $entry.protocols -split ", ";
        SourceAddresses = $entry.SourceAddresses -split ", ";
        DestinationAddresses = $entry.DestinationAddresses -split ", ";
        SourceIPGroups = $entry.SourceIPGroups -split ", ";
        DestinationIPGroups = $entry.DestinationIPGroups -split ", ";
        DestinationPorts = $entry.DestinationPorts -split ", ";
        DestinationFQDNs = $entry.DestinationFQDNs -split ", ";
    }
    $obj = New-Object psobject -Property $properties
    $RulesfromCSV += $obj
}

$RulesfromCSV
Clear-Variable rules
$rules = @()
foreach ($entry in $RulesfromCSV)
{
    $RuleParameter = @{
        Name = $entry.Name;
        Protocol = $entry.protocols
        sourceAddress = $entry.SourceAddresses
        DestinationAddress = $entry.DestinationAddresses
        DestinationPort = $entry.DestinationPorts
    }
    $rule = New-AzFirewallPolicyNetworkRule @RuleParameter
    $NetworkRuleCollection = @{
        Name = $entry.RuleCollectionName
        Priority = $entry.RulePriority
        ActionType = $entry.ActionType
        Rule       = $rules += $rule
    }
}

# Create a network rule collection
$NetworkRuleCategoryCollection = New-AzFirewallPolicyFilterRuleCollection @NetworkRuleCollection
# Deploy to created rule collection group
Set-AzFirewallPolicyRuleCollectionGroup -Name $targetrcg.Name -Priority 200 -RuleCollection $NetworkRuleCategoryCollection -FirewallPolicyObject $targetfp
