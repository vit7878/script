$computerNames = @('dev-host-02')

$User = "ETR\v.shakhov"
$PWord = ConvertTo-SecureString -String "Dspljhfdkbdfq02" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

foreach ( $computerName in $computerNames ) {
Invoke-Command -ComputerName $computerName -ScriptBlock {
Get-VMHostSupportedVersion | ft

} -Credential $Credential
}

