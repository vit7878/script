#Set-ExecutionPolicy Unrestricted
$computerName = "etr-vpn-03"
$User = "ETR\svg"
$PWord = ConvertTo-SecureString -String "Pjjnt[ybrfDRdflhfnt#01" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Invoke-Command -ScriptBlock {


function CreateObj {
    $result = New-Object -TypeName PSObject
    $IPadd = '123.123.123.123'
    $StartTime1 = (Get-Date).AddMinutes(-20).ToString('MM/dd/yyyy HH:mm:ss')
    $StartTime2 = (Get-Date).addHours(-400).ToString('MM/dd/yyyy HH:mm:ss')
    $Now = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
    [string[]]$SesId = Get-Content -Path 'C:\Admin\VPNLog\ActiveSessions.txt'
    $stat1 = Get-RemoteAccessConnectionStatistics -StartDateTime $StartTime1 -EndDateTime $Now


    $stat = $stat1 | 
        Select-Object  @{Name='SessionID';    Expr={$_.SessionID}},
                    @{Name='ConnectionStartTime';    Expr={$_.ConnectionStartTime}},
                    @{Name='UserName';    Expr={$_.UserName}},
                    @{Name='TunnelType';    Expr={$_.TunnelType}},
                    @{Name='ClientIPAddress';    Expr={$_.ClientIPAddress}},
                    @{Name='ClientExternalAddress';    Expr={$_.ClientExternalAddress}},
                    @{Name='ConnectionDuration';    Expr={$_.ConnectionDuration}},
                    @{Name='TotalBytesIn';    Expr={$_.TotalBytesOut}},
                    @{Name='IPadd';    Expr={$IPadd}}
    
    $sum = $stat1 | ForEach-Object {
    
        $activity = Get-RemoteAccessUserActivity -StartDateTime $StartTime1 -EndDateTime $Now -SessionId $_.SessionID

 
        
    
    
    
    }
  

    return $sum 
}

$res = CreateObj


$res

#$result = (Get-RemoteAccessConnectionStatistics -StartDateTime $StartTime -EndDateTime $Now | Select-Object -Property SessionID, ConnectionStartTime, UserName, TunnelType, ClientIPAddress, ClientExternalAddress, ConnectionDuration, TotalBytesIn, TotalBytesOut | ConvertTo-Csv -NoTypeInformation) | Select-Object -Skip 1
#$result = Get-RemoteAccessConnectionStatistics -StartDateTime $StartTime -EndDateTime $EndTime | where -Property SessionId -Like "1000" | Select-Object *
#$result = Get-RemoteAccessConnectionStatistics | where -Property SessionId -Like "2591" | Select-Object *
#$result.UserName   
    





} -ComputerName $computerName -Credential $Credential


    
