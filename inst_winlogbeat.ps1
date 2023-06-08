Set-ExecutionPolicy Unrestricted

#Ввести имя компа для установки
$computerName = 'te-sync-03'

#Если конфиг типовой, то менять не надо
$file_yml = '\\etr-fs-01\distr\Winlogbeat\winlogbeat.yml'

$file_inst = '\\etr-fs-01\distr\Winlogbeat\winlogbeat-8.6.0-windows-x86_64.msi'

$DataStamp = get-date -Format yyyyMMddTHHmmss
$logFile = '{0}-{1}.log' -f $file.fullname,$DataStamp
$MSIArguments = @(
    "/i"
    ('"{0}"' -f $file.fullname)
    "/qn"
    "/norestart"
    "/L*v"
    $logFile
)

Copy-Item -Path $file_inst -Destination "\\$computername\c$\windows\temp\installer.msi"
Invoke-Command -ComputerName $computerName -ScriptBlock {Start-Process msiexec.exe -Wait -ArgumentList '/I C:\windows\temp\installer.msi /quiet'}
Copy-Item -Path $file_yml -Destination "\\$computername\c$\ProgramData\Elastic\beats\Winlogbeat\winlogbeat.yml"
Invoke-Command -ScriptBlock {Get-Service -Name winlogbeat | Start-Service} -ComputerName $computerName -Credential (Get-Credential)