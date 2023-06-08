$FILE = Get-Content -Path 'C:\script\Disks\ADUReport.txt'
$results=@()
$hostname = hostname
foreach ($LINE in $FILE) 
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
$results > C:\script\Disks\$hostname.txt