$resourceGroupName = "mate-azure-task-5"

$disks = Get-AzDisk -ResourceGroupName $resourceGroupName


$unattachedDisks = $disks | Where-Object { $_.DiskState -eq "Unattached" -or !$_.ManagedBy }

$result = $unattachedDisks | ForEach-Object {
    [PSCustomObject]@{
        Name               = $_.Name
        DiskSizeGB         = $_.DiskSizeGB
        Location           = $_.Location
        DiskState          = $_.DiskState
        ResourceGroupName  = $_.ResourceGroupName
        Sku                = @{
            Name = $_.Sku.Name
        }
        ManagedBy          = if ($_.ManagedBy) { $_.ManagedBy } else { $null }
    }
}

$result | ConvertTo-Json -Depth 3 | Out-File -Encoding UTF8 -FilePath "result.json"
