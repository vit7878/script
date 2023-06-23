 Get-ADUser -Properties description -Filter * -SearchBase "OU=Service Accounts,OU=ETR-RU,DC=etr,DC=eastbanctech,DC=ru" | select name, description | ft -AutoSize >> C:\script\res.csv



 $Sbase1 = 'OU=Disabled Accounts,DC=etr,DC=eastbanctech,DC=ru'
 $Sbase2 = 'OU=Users,OU=ETR-RU,DC=etr,DC=eastbanctech,DC=ru' 
 $myVar = 'bannikov'
 Get-ADUser -Filter {Surname -like $myVar} -searchbase $Sbase1 -Properties extensionAttribute1 | Select-Object SamAccountName, extensionAttribute1



 Get-ADUser v.mirniy -properties PasswordExpired, PasswordLastSet, PasswordNeverExpires, lastlogontimestamp, extensionAttribute1



 Get-ADUser -Identity v.skabina -Properties LastLogon | Select-Object Name, @{Name='LastLogon';Expression={[DateTime]::FromFileTime($_.LastLogon)}}