
#Set-ExecutionPolicy Unrestricted
$computerName = "etr-vpn-03"
$User = "ETR\svg"
$PWord = ConvertTo-SecureString -String "Pjjnt[ybrfDRdflhfnt#01" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord
Invoke-Command -ScriptBlock {



    $StartTime = (Get-Date).AddMinutes(-60).ToString('MM/dd/yyyy HH:mm:ss')
    $Now = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
    $Stat = Get-RemoteAccessConnectionStatistics -StartDateTime $StartTime -EndDateTime $Now | Select-Object *
    $ToFile = @()
    foreach ($StatItem in $Stat) {
        $activity = Get-RemoteAccessUserActivity -StartDateTime $StatItem.ConnectionStartTime -EndDateTime $StatItem.ConnectionStartTime.AddSeconds($StatItem.ConnectionDuration) -UserName $StatItem.UserName
        $UnicIP = @()
        foreach ($ActivityItem in $Activity) {
            if ($UnicIP -notcontains $ActivityItem.ServerIpAddress) {
                $UnicIP += $ActivityItem.ServerIpAddress
                $ToFile += [PSCustomObject]@{ConnectionStartTime = $StatItem.ConnectionStartTime; 
                    SessionID                                    = $StatItem.SessionID; 
                    UserName                                     = $StatItem.UserName; 
                    TunnelType                                   = $StatItem.TunnelType; 
                    ClientIPAddress                              = $StatItem.ClientIPAddress; 
                    ClientExternalAddress                        = $StatItem.ClientExternalAddress; 
                    ConnectionDuration                           = [int32](($StatItem.ConnectionDuration) / 60); 
                    TotalBytesIn                                 = [int32](($StatItem.TotalBytesIn) / 1MB);
                    TotalBytesOut                                = [int32](($StatItem.TotalBytesOut) / 1MB); 
                    IPadd                                        = $ActivityItem.ServerIpAddress
                }      
            }
        } 
    }
($ToFile | ConvertTo-Csv -NoTypeInformation) | Select-Object -Skip 1 | Add-Content -Path "C:\Admin\VPNLog\vpnlog.log"



 


} -ComputerName $computerName -Credential $Credential


    
