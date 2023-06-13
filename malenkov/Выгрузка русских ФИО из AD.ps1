Set-ExecutionPolicy unRestricted
Get-ADUser -Properties * -Filter * -SearchBase "OU=Users,OU=ETR-RU,DC=etr,DC=eastbanctech,DC=ru" | Sort-Object etrRussianDisplayName | select etrRussianDisplayName