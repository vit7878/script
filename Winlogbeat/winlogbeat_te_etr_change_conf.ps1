#Set-ExecutionPolicy Unrestricted

[string[]]$computerNames = Get-Content -Path '\\etr-fs-01\Infrastructure\Distr\Winlogbeat\servers_test_new_conf2.txt'

#Если конфиг типовой, то менять не надо
$file_yml = '\\etr-fs-01\Infrastructure\Distr\Winlogbeat\winlogbeat_05062023.yml'

$User = "ETR\svg"
$PWord = ConvertTo-SecureString -String "Pjjnt[ybrfDRdflhfnt#01" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

foreach ( $computerName in $computerNames ) {
echo $computername
$test = Test-Connection -ComputerName $computerName -Quiet
if ( $test ) 
{
	$Result3 = Test-Path \\$computername\c$\ProgramData\Elastic\beats\Winlogbeat\winlogbeat.yml
		if ( $Result3 )
		{
		Copy-Item -Path $file_yml -Destination "\\$computername\c$\ProgramData\Elastic\beats\Winlogbeat\winlogbeat.yml" -Force -Verbose
		Invoke-Command -ScriptBlock {Get-Service -Name winlogbeat | Restart-Service} -ComputerName $computerName -Credential $Credential
		Start-Sleep -Seconds 2
		$arrService = Get-Service -Name winlogbeat -ComputerName $computerName
		if ( $arrService.Status -eq 'Running' )
			{
			Write-Output "Service winlogbeat is RUNNING"
			}
		else
			{
			Write-Warning "Service winlogbeat is NOT RUNNING"
			}
		Write-Output " "
		}
}
else
{
	echo "$computername is unreacheble"
	echo " "
}
}


