Get-ADComputer -Filter * -SearchBase "OU=Computers,OU=ETR-RU,DC=etr,DC=eastbanctech,DC=ru" -Properties *  | Select-Object -Property Name, DNSHostName, Enabled, LastLogonDate | 
Export-CSV "C:\script\CompList.csv" -NoTypeInformation -Encoding UTF8