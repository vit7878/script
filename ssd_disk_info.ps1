$folder_rep = New-Item "$env:TMP\ADUReport" -ItemType Directory -force
#Start-Process "C:\Program Files\Smart Storage Administrator\ssacli\bin\ssacli" -ArgumentList "ctrl slot=0 diag file=$folder_rep\ADUReport.zip" -Wait
#Expand-Archive -Path "$folder_rep\ADUReport.zip" -DestinationPath "$folder_rep" -Force

$file_txt = Get-Content -Path "$folder_rep\ADUReport.txt"

$disks = @()
$TBW_Types = @{
    Micron_5200_MTFD = 8400
    Micron_5100_MTFD = 8400
    Micron_5300_MTFD = 9100
    SSDSC2BB80 = 450
    SU750 = 800
    SU800 = 800
}

$drive_model = $file_txt -match "Drive Model" | ForEach-Object { $_.Trim().Split()[-1] }
$drive_serial = ($file_txt -match "Drive Serial Number").Trim() | ForEach-Object { $_.Split()[-1] }
$drive_utilization = $file_txt -match "Industry Standard SSD Utilization" | ForEach-Object { $_.Split()[-1] }
$drive_poweron = $file_txt -match "Power-on Hours" | ForEach-Object { $_.Split()[-1] }
$drive_tbw = $file_txt -match "Total Bytes Written" | ForEach-Object { $_.Split()[-1] }
$drive_temp = $file_txt -match "Current Temperature" | ForEach-Object { $_.Split()[-1] }

for ($i = 0; $i -lt $drive_model.Length; $i++) {
    if ([math]::Round($drive_tbw[$i]) -gt $TBW_Types[$drive_model[$i]]*0.8 -or $drive_utilization[$i] -gt 50) {
        $Warning = "!!! ALARM !!!"
    }
    else { $Warning = "Ok" }

    $disks += @{
        Model       = $drive_model[$i]
        Serial      = $drive_serial[$i]
        Utilization = [int]$drive_utilization[$i]
        Health      = 100 - $drive_utilization[$i]
        PowerOn     = $drive_poweron[$i]
        TBW         = [math]::Round($drive_tbw[$i])
        Temperature = [uint32]$drive_temp[$i]
        Warning     = $Warning
    }
}

$report = $disks | ForEach-Object {
    [PSCustomObject]@{
        Model   = $_.Model
        Serial  = $_.Serial
        PowerOn = $_.PowerOn
        Health  = $_.Health
        TBW     = $_.TBW
        Temperature = $_.Temperature
        Warning = $_.Warning
    }
} | ConvertTo-Html | Out-String

#Remove-Item -Path "$folder_rep" -recurse

$hostname = "etr-host-14"

#Send-MailMessage -From 'te_admins <te_admins@trueengineering.ru>' -To 'te_admins <te_admins@trueengineering.ru>' -Subject "IP Address - '$ipV4str' ComputerName - '$compName'" -Body $finaloutput -SmtpServer 192.168.150.49 -Encoding $encoding
Send-MailMessage -From 'v.shakhov@trueengineering.ru' -To 'v.shakhov@trueengineering.ru' -Subject "Condition SSD-disks on $hostname" -Body $report -BodyAsHtml -SmtpServer 192.168.150.49

