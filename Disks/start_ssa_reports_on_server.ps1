$User = "ETR\v.shakhov"
$PWord = ConvertTo-SecureString -String "Dspljhfdkbdfq02" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
$hostname = hostname
$FolderName = (Get-Date).tostring('yyyy-MM-dd')
$PathToRep = "\\etr-fs-01\Infrastructure\Disk_testing"
$FILE_TXT = Get-Content -Path 'C:\dst\ADUReport\ADUReport.txt'
$results=@()

Start-Process "C:\Program Files\Smart Storage Administrator\ssacli\bin\ssacli" -ArgumentList "ctrl slot=0 diag file=c:\dst\ADUReport\ADUReport.zip" -Wait
Expand-Archive -Path "c:\dst\ADUReport\ADUReport.zip" -DestinationPath "c:\dst\ADUReport" -Force

foreach ($LINE in $FILE_TXT) 
{
$out=$LINE | Select-String -Pattern "Drive Model"
$results+=$out
$out=$LINE | Select-String -Pattern "Drive Serial Number"
$results+=$out
$out=$LINE | Select-String -Pattern "Industry Standard SSD Utilization"
$results+=$out
$out=$LINE | Select-String -Pattern "Power-on Hours"
$results+=$out
$out=$LINE | Select-String -Pattern "Total Bytes Written"
$results+=$out
}
$results > c:\dst\ADUReport\result.txt

New-PSDrive -Name Z -PSProvider FileSystem -root $PathToRep -Credential $Credential
New-Item -ItemType Directory -Path $PathToRep -Name $FolderName -f
Copy-Item -Path "c:\dst\ADUReport\result.txt" -Destination "Z:\$FolderName\$hostname.txt"
Remove-Item -Path "c:\dst\ADUReport" -recurse
Remove-PSDrive -Name Z