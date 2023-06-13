Set-ExecutionPolicy Unrestricted

cmd /c pause

net stop TNIResidentAgent
Start-Sleep -Seconds 10

net start TNIResidentAgent
Start-Sleep -Seconds 10

C:\Windows\TNIRESIDENTAGENT\tniwinagent.exe \testrun

Start-Sleep -Seconds 30
$Log = C:\Windows\TNIRESIDENTAGENT\tniwinagent.log

net stop TNIResidentAgent

$compName = (Get-ComputerInfo).CsName
Send-MailMessage -From 'te_admins <te_admins@trueengineering.ru>' -To 'a.malenkov <a.malenkov@trueengineering.ru>' -Subject "ComputerName - '$compName'" -Attachments C:\Windows\TNIRESIDENTAGENT\tniwinagent.log -SmtpServer 192.168.150.49
Start-Sleep -Seconds 30
net start TNIResidentAgent