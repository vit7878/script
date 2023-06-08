#Включение работы сценариев
Set-ExecutionPolicy Unrestricted
#Загрузка и восстановление
$CrashBehavior = Get-WmiObject Win32_OSRecoveryConfiguration -EnableAllPrivileges

Start-Sleep -Seconds 2

#Выключаем флаг "Выполнить автоматическую перезагрузку" и выставляем тип дебага "Малый дамп памяти"
$CrashBehavior | Set-WmiInstance -Arguments @{ AutoReboot=$false; DebugInfoType=3 }

Start-Sleep -Seconds 2

#Включаем RDP
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server'-name "fDenyTSConnections" -Value 0
(Get-WmiObject -class "Win32_TSGeneralSetting" -Namespace root\cimv2\terminalservices -Filter "TerminalName='RDP-tcp'").SetUserAuthenticationRequired(0)

Start-Sleep -Seconds 2

#Устанавливаем часовой пояс "НСК"
Set-TimeZone -Id 'N. Central Asia Standard Time'

Start-Sleep -Seconds 2

#Добавляем доп раскладку клавиатуры
Set-WinUserLanguageList en-US, ru

Start-Sleep -Seconds 2

#Регион-Формат-выставляем в язык системы
Set-WinCultureFromLanguageListOptOut 1


#Выключаем AutoUpdate для WindowsStore
$Name = “AutoDownload”
$Value = 2
$Path = “HKLM:\SOFTWARE\Policies\Microsoft\WindowsStore”
If ((Test-Path $Path) -eq $false){
New-Item -Path $Path -ItemType Directory
}
If (-!(Get-ItemProperty -Path $Path -Name $name -ErrorAction SilentlyContinue)){
New-ItemProperty -Path $Path -Name $Name -PropertyType DWord -Value $Value
}
else{
Set-ItemProperty -Path $Path -Name $Name -Value $Value
}
Write-Host "AutoUpdate WindowsStore выключен"




#включение учетки локального администратор и задание пароля
Get-LocalUser -Name "Администратор" | Enable-LocalUser
Set-LocalUser "Администратор" -AccountNeverExpires
$NewPassword = ConvertTo-SecureString "Teupotik9" –AsPlainText –Force
Set-LocalUser –Name Администратор –Password $NewPassword

#Выключение работы сценариев
Set-ExecutionPolicy Restricted