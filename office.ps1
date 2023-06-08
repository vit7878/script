function office_version {
    $paths = @(
    "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun"
)
    $officeVersion = ""
foreach ($path in $paths) {
    # Check to see if path exists
    if (Test-Path -Path "$path\Configuration") {
        $officeVersion = (Get-ItemProperty -Path "$path\Configuration" -Name "VersionToReport").VersionToReport
    }
}
return $officeVersion
}

$current_build = "16.0.10396.20023"
$result = @()
$before = office_version
$hostname = hostname

if ($before -eq $current_build)
{
    $result = $hostname + "`n" + "Current version: " + $before + "`n" + "No update required"
}
else {
    Start-Process -FilePath "C:\Program Files\Common Files\microsoft shared\ClickToRun\OfficeC2RClient.exe" -ArgumentList "/update","user","displaylevel=false" -Wait
    $after = office_version
    $result = $hostname + "`n" + "Current version: " + $before + "`n" + "Office updated to version " + $after
}

$to_mail =""
$to_mail = $result | Out-String

Send-MailMessage -From 'v.shakhov@trueengineering.ru' -To 'v.shakhov@trueengineering.ru' -Subject "Condition Microsoft Office on $hostname" -Body $to_mail -BodyAsHtml -SmtpServer 192.168.150.49