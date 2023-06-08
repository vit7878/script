#Set-ExecutionPolicy Unrestricted

[string[]]$computerNames = Get-Content -Path '\\etr-fs-01\distr\Winlogbeat\servers.txt'

#Если конфиг типовой, то менять не надо
$file_yml = '\\etr-fs-01\distr\Winlogbeat\winlogbeat.yml'

$User = "ETR\v.shakhov"
$PWord = ConvertTo-SecureString -String "CHAEGE_ME" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

$file_inst = '\\etr-fs-01\distr\Winlogbeat\winlogbeat-8.6.0-windows-x86_64.msi'

foreach ( $computerName in $computerNames ) {
echo $computername
$test = Test-Connection -ComputerName $computerName -Quiet
if ( $test ) 
{
$Result0 = Get-WmiObject -ComputerName $computerName -Class Win32_Product | where vendor -eq Elastic | where version -eq 8.6.0
if ( $Result0 )
{
	echo "Winlogbeat already installed!"
	echo " "
	continue
}
else
{
Copy-Item -Path $file_inst -Destination "\\$computername\c$\windows\temp\installer.msi"
$Result1 = Test-Path \\$computername\c$\windows\temp\installer.msi
if ( $Result1 )
{
    Write-Output "Copy installer: OK"
}
else
{
    Write-Warning "Copy installer: FALSE"
}
Invoke-Command -ComputerName $computerName -ScriptBlock {Start-Process msiexec.exe -Wait -ArgumentList '/I C:\windows\temp\installer.msi /quiet'} -Credential $Credential
$Result2 = Get-WmiObject -ComputerName $computerName -Class Win32_Product | where vendor -eq Elastic | where version -eq 8.6.0
if ( $Result2 )
{
    Write-Output "Install Winlogbeat application: OK"
}
else
{
    Write-Warning "Install Winlogbeat application: FALSE"
}
Copy-Item -Path $file_yml -Destination "\\$computername\c$\ProgramData\Elastic\beats\Winlogbeat\winlogbeat.yml"
$Result3 = Test-Path \\$computername\c$\ProgramData\Elastic\beats\Winlogbeat\winlogbeat.yml
if ( $Result3 )
{
    Write-Output "Copy winlogbeat.yml: OK"
}
else
{
    Write-Warning "Copy winlogbeat.yml: FALSE"
}
Invoke-Command -ScriptBlock {Get-Service -Name winlogbeat | Start-Service} -ComputerName $computerName -Credential $Credential
$arrService = Get-Service -Name winlogbeat -ComputerName $computerName
if ( $arrService.Status -eq 'Running' )
{
    Write-Output "Service winlogbeat is RUNNING"
}
else
{
    Write-Warning "Service winlogbeat is NOT RUNNING"
}
echo " "
}
}
else
{
	echo "$computername is unreacheble"
	echo " "
}
}

