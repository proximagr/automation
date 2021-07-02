# 1. You need to login to the Azure Rm Account

#Login-AzAccount

# 2. The script will query the Subscriptions that the login account has access and will promt the user to select the target Subscription from the drop down list
 
$subscription = Get-AzSubscription | Out-GridView -Title "Select a Subscription" -PassThru
Select-AzSubscription -SubscriptionId $subscription.Id

# 3. The script will query the available VMs and promt to select the target VM from the VM list
 
$vm = Get-AzVM | Out-GridView -Title "Select the Virtual Machine to add Data Disks to" -PassThru

# 4. I set the storage type based on the OS disk. If you want to spesify somehting else you can cahnge this to: $storageType = StandardLRS or PremiumLRS etc.

$storageType = $VM.StorageProfile.OsDisk.ManagedDisk.StorageAccountType

# 5. Enter how many data disks you need to create

$VMdiskCapacity = ($VM.StorageProfile.DataDisks).Capacity
 
$diskquantity = Read-Host "How many disks you need to create? Max Capacity" $VMdiskCapacity "."

# 6. The script will promt for disk size, in GB

$diskSizeList = @()
for($i = 1; $i -le $diskquantity; $i++)
{
    $disk = (Read-Host "Disk " $i " Size")
    $diskSizeList += $disk
}
$diskSizeList

# 7. check for exisiting disks

$existinglun = @()
for($i = 0; $i -lt $VMdiskCapacity; $i++) {
    $existinglun += ($VM.StorageProfile.DataDisks)[$i].Lun
}

# 8. disks creation

for($i = 0; $i -lt $diskquantity; $i++)
{
$diskName = $vm.Name + "-DataDisk-" + $i.ToString()
$diskConfig = New-AzDiskConfig -AccountType $storageType -Location $vm.Location -CreateOption Empty -DiskSizeGB $diskSizeList[$i]
$DataDisk = New-AzDisk -DiskName $diskName -Disk $diskConfig -ResourceGroupName $vm.ResourceGroupName
for ($j = 0; $j -lt $VMdiskCapacity; $j++) {
    if ( $null -eq $existinglun[$j] ) {
        $nextLunIndex
        for ($k = 0; $k -lt $VMdiskCapacity; $k++ ) {
            $nextLunIndex = $k
            for ( $m = 0; $m -lt $VMdiskCapacity; $m++ ) {
                if ( $k -eq $existinglun[$m] ) {
                    $nextLunIndex = -1 
                    break 
                }
            }
            if ($nextLunIndex -ne -1 ) {
                break
            }
        }
        Add-AzVMDataDisk -VM $vm -Name $DiskName -CreateOption Attach -ManagedDiskId $DataDisk.Id -Lun $nextLunIndex
        $existinglun[$j] = $nextLunIndex
        break
    } 
}
}
Update-AzVM -VM $vm -ResourceGroupName $vm.ResourceGroupName