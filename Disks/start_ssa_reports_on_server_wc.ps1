$hostname = hostname
#$FolderName = (Get-Date).tostring('yyyy-MM-dd')
#$PathToRep = "\\etr-fs-01\Infrastructure\Disk_testing"

mkdir $env:TMP\ADUReport | Out-Null
Start-Process "C:\Program Files\Smart Storage Administrator\ssacli\bin\ssacli" -ArgumentList "ctrl slot=0 diag file=$env:TMP\ADUReport\ADUReport.zip" -Wait
Expand-Archive -Path "$env:TMP\ADUReport\ADUReport.zip" -DestinationPath "$env:TMP\ADUReport" -Force

$file_txt = Get-Content -Path "$env:TMP\ADUReport\ADUReport.txt"
$results = @()

foreach ($LINE in $file_txt) {
    $out = $LINE | Select-String -Pattern "Drive Model"
    $results += $out
    $out = $LINE | Select-String -Pattern "Drive Serial Number"
    $results += $out
    $out = $LINE | Select-String -Pattern "Industry Standard SSD Utilization"
    $results += $out
    $out = $LINE | Select-String -Pattern "Power-on Hours"
    $results += $out
    $out = $LINE + "`n----------------------------------------------------------------------" | Select-String -Pattern "Total Bytes Written"
    $results += $out
}
$results > $env:TMP\ADUReport\res.txt 

New-PSDrive -Name Z -PSProvider FileSystem -root $PathToRep
New-Item -ItemType Directory -Path $PathToRep -Name $FolderName -f
Copy-Item -Path "c:\dst\ADUReport\result.txt" -Destination "Z:\$FolderName\$hostname.txt"
Remove-Item -Path "c:\dst\ADUReport" -recurse
Remove-PSDrive -Name Z

$encoding = [System.Text.Encoding]::UTF8
Send-MailMessage -From 'te_admins <te_admins@trueengineering.ru>' -To 'te_admins <te_admins@trueengineering.ru>' -Subject "IP Address - '$ipV4str' ComputerName - '$compName'" -Body $finaloutput -SmtpServer 192.168.150.49 -Encoding $encoding