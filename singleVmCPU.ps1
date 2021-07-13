$vmname = Read-Host 'Enter the VM name'
$rgname  = Read-Host 'Enter the Resource Group name'
$acpu  = Read-Host 'Enter the CPU percentance ammount'
$VM = Get-AzVM -Name $vmname -ResourceGroupName $rgname
$endTime = Get-Date
$startTime = $endTime.AddMinutes(-730)
$timeGrain = '01:00:00'
$metricName = 'Percentage CPU'
$metricData = Get-AzMetric -ResourceId $VM.id -TimeGrain $timeGrain -StartTime $startTime -EndTime $endTime -MetricNames $metricName -warningaction "SilentlyContinue"
Write-Host "CPU above " $acpu "% for " $vm.name " VM:"
$metricData.Data.Where({$_.Average -gt $acpu}) | ft TimeStamp,Average