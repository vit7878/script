### Скрипт запуска генерации SSA-отчетов на хостах виртуализации

### Список хостов для сбора SSA-отчетов
[string[]]$computerNames = Get-Content -Path '\\etr-fs-01\Infrastructure\Disk_testing\servers.txt'

### Перед запуском скрипта нужно отредактировать данные пользователя
$User = "ETR\CHANGE_ME"
$PWord = ConvertTo-SecureString -String "CHANGE_ME" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

### Создаём папку, куда будут падать отчеты с хостов. В названии папки текущая дата
$PathToRep = "\\etr-fs-01\Infrastructure\Disk_testing\"
$FolderName = (Get-Date).tostring('yyyy-MM-dd') 
New-Item -ItemType Directory -Path $PathToRep -Name $FolderName -f

### Для каждого сервера из списка выполняется набор команд
foreach ( $computerName in $computerNames ) {
Invoke-Command -ComputerName $computerName -ScriptBlock {
	
$User = "ETR\CHANGE_ME"
$PWord = ConvertTo-SecureString -String "CHANGE_ME" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
$hostname = hostname
$FolderName = (Get-Date).tostring('yyyy-MM-dd')
$PathToRep = "\\etr-fs-01\Infrastructure\Disk_testing"

### Запуск генерации отчета SSACli
Start-Process "C:\Program Files\Smart Storage Administrator\ssacli\bin\ssacli" -ArgumentList "ctrl all diag file=c:\$hostname.zip" -Wait
New-PSDrive -Name Z -PSProvider FileSystem -root $PathToRep -Credential $Credential
Copy-Item -Path "c:\$hostname.zip" -Destination "Z:\$FolderName\$hostname.zip"
Remove-Item -Path "c:\$hostname.zip"
Remove-PSDrive -Name Z
Expand-Archive -Path "$PathToRep\$FolderName\$hostname.zip" -DestinationPath "$PathToRep\$FolderName\$hostname" -Force
} -Credential $Credential

Remove-Item -Path "$PathToRep\$FolderName\*.zip" -force
}

