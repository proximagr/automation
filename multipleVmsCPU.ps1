$vmlist = Import-Csv ./vmlist.csv
$acpu  = Read-Host 'Enter the CPU percentance ammount'
foreach ($vm in $vmlist) {
	$myvm = Get-AzVM -name $vm.vmname -ResourceGroupName $vm.resourcegroupname
	$endTime = Get-Date
	$startTime = $endTime.AddMinutes(-730)
	$timeGrain = '01:00:00'
	$metricName = 'Percentage CPU'
	$metricData = Get-AzMetric -ResourceId $myvm.id -TimeGrain $timeGrain -StartTime $startTime -EndTime $endTime -MetricNames $metricName -warningaction "SilentlyContinue"
	$cpuabove = "CPU above "
	$for = "% for "
	Write-Output "$cpuabove $acpu $for $($vm.vmname)"
	$metricData.Data.Where({$_.Average -gt $acpu}) | ft TimeStamp,Average
	}
