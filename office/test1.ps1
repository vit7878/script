$Keys = Get-Item -Path HKLM:\Software\RegisteredApplications | Select-Object -ExpandProperty property
$Product = $Keys | Where-Object {$_ -Match "Outlook.Application."}
$OfficeVersion = ($Product.Replace("Outlook.Application.","")+".0")
Write-Host $OfficeVersion