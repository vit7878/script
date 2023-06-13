Set-ExecutionPolicy Unrestricted

cmd /c pause

gpupdate /force
Start-Sleep -Seconds 15

gpupdate /force
Start-Sleep -Seconds 15

Restart-Service wuauserv
Start-Sleep -Seconds 15

$Pochta = Test-NetConnection 192.168.150.49 -port 25
if ($Pochta.TcpTestSucceeded)
    { $successPochta = "Pochta - OK" }
else
    { Write-Host "Похоже у вас не подключен VPN, переподключитесь и запустите скрипт заново!" 
        Start-Sleep -Seconds 15
            Exit
    }

$Wsus = Test-NetConnection etr-wsus-02.etr.eastbanctech.ru -port 8530
if ($Wsus.TcpTestSucceeded) 
    { $successWsus = "Wsus - OK" }
else
    { Write-Host "Похоже У вас не подключен VPN, переподключитесь и запустите скрипт заново!" 
        Start-Sleep -Seconds 15
            Exit
    }


wuauclt /resetauthorization /detectnow /reportnow
Start-Sleep -Seconds 300

Get-WindowsUpdateLog -LogPath $env:temp\UpdateLog.log

$compName = (Get-ComputerInfo).CsName
$finaloutput = $successWsus + "`r`n" + $successPochta
Send-MailMessage -From 'te_admins <te_admins@trueengineering.ru>' -To 'a.malenkov <a.malenkov@trueengineering.ru>' -Subject "ComputerName - '$compName'" -Body $finaloutput -Attachments $env:temp\UpdateLog.log -SmtpServer 192.168.150.49
