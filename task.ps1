
$resourceGroup = "mate-azure-task-5"
$outputPath = "result.json"

$disks = Get-AzDisk -ResourceGroupName $resourceGroup

$unattachedDisks = $disks | Where-Object { !$_.ManagedBy }

$diskNames = $unattachedDisks | Select-Object -ExpandProperty Name

$diskNames | ConvertTo-Json -Depth 1 | Out-File -Encoding UTF8 $outputPath

Write-Host "✅ Unattached disks saved to $outputPath"
# Write your code here
