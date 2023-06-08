[string[]]$groupsNames = Get-Content -Path 'C:\script\office\groups.txt'

foreach ( $groupName in $groupsNames ) {
Get-ADGroupMember $groupName | ForEach {Get-ADUser -filter {samaccountname -eq $_.SamAccountName} -Properties displayName, department, extensionAttribute1}| Format-Table displayName, department, extensionAttribute1 -AutoSize >> result.csv
}




C:\Program Files\Smart Storage Administrator\ssacli\bin\ssacli.exe