
#Set-ExecutionPolicy Unrestricted
$computerName = "etr-dpm-01.etr.eastbanctech.ru"
$User = "ETR\svg"
$PWord = ConvertTo-SecureString -String "Pjjnt[ybrfDRdflhfnt#01" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
Invoke-Command -ScriptBlock {




#$PG = "Even days" #Protection Group name of affected data source.
#$DS = "te-confl-01" #Data source name, for example Virtual Machine name or SQL Database name.
#$DPM = "etr-dpm-01.etr.eastbanctech.ru" #FQDN of your DPM Server.
 
#$PGroup = Get-DPMProtectionGroup -DPMServerName $DPM | where { $_.Name -EQ $PG }; $PGroup
 
#$PObject = Get-DPMDatasource -ProtectionGroup $PGroup | where { $_.Name -EQ $DS }; $PObject
 
#$RPoint = Get-DPMRecoveryPoint -Datasource $PObject | select -Last 1; $RPoint
 
#Remove-DPMRecoveryPoint -RecoveryPoint $RPoint

$pg = Get-DPMProtectionGroup | ogv -PassThru
$pg


} -ComputerName $computerName -Credential $Credential