#Azure Backup VMs Automation

#Variables
#Get Recovery Services Vault
$ResourceGroupName = "myappb"
$VaultName = "myappb-backup"
$vault = Get-AzRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $VaultName
$vmName = "myappb"
$targetPolicyName = "myappb-policy"

#Change policy for backup items
$targetPolicy = Get-AzRecoveryServicesBackupProtectionPolicy -Name $targetPolicyName -VaultId $vault.ID
$backupItem = Get-AzRecoveryServicesBackupItem -WorkloadType AzureVM -BackupManagementType AzureVM -Name $vmName -VaultId $vault.ID
Enable-AzRecoveryServicesBackupProtection -Item $backupItem -Policy $targetPolicy -VaultId $vault.ID

#Stop protection
$backupItem = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureVM -WorkloadType AzureVM -Name $vmName -VaultId $vault.ID
Disable-AzRecoveryServicesBackupProtection -Item $backupItem -VaultId $vault.ID -Force

#Stop protection for multiple vms | create a file named stopProtection.ps1 and add the following code
$ResourceGroupName = "myappb"
$VaultName = "myappb-backup"
$vault = Get-AzRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $VaultName
$targetPolicyName = "myappb-policy"
$vmNames = "myappb", "myappb2"
foreach ($vmName in $vmNames)
{
    $backupItem = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureVM -WorkloadType AzureVM -VaultId $vault.ID -Name $vmName
    Disable-AzRecoveryServicesBackupProtection -Item $backupItem -VaultId $vault.ID -Force
}
 
#Resume protection
$targetPolicy = Get-AzRecoveryServicesBackupProtectionPolicy -Name $targetPolicyName -VaultId $vault.ID
$backupItem = Get-AzRecoveryServicesBackupItem -WorkloadType AzureVM -BackupManagementType AzureVM -Name $vmName -VaultId $vault.ID
Enable-AzRecoveryServicesBackupProtection -Item $backupItem -Policy $targetPolicy -VaultId $vault.ID

#Resume protection for multiple vms | create a file named resumeProtection.ps1 and add the following code
$ResourceGroupName = "myappb"
$VaultName = "myappb-backup"
$vault = Get-AzRecoveryServicesVault -ResourceGroupName $ResourceGroupName -Name $VaultName
$targetPolicyName = "myappb-policy"
$targetPolicy = Get-AzRecoveryServicesBackupProtectionPolicy -Name $targetPolicyName -VaultId $vault.ID
$vmNames = "myappb", "myappb2"
foreach ($vmName in $vmNames)
{
    $backupItem = Get-AzRecoveryServicesBackupItem -BackupManagementType AzureVM -WorkloadType AzureVM -VaultId $vault.ID -Name $vmName
    Enable-AzRecoveryServicesBackupProtection -Item $backupItem -Policy $targetPolicy -VaultId $vault.ID
}

#Source: https://learn.microsoft.com/en-us/azure/backup/backup-azure-vms-automation#change-policy-for-backup-items
