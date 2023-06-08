 $drives = [System.IO.DriveInfo]::GetDrives() |
    Where-Object {$_.TotalSize} |
    Select-Object   @{Name='Name';     Expr={$_.Name}},
                    @{Name='Label';    Expr={$_.VolumeLabel}},
                    @{Name='Size(GB)'; Expr={[int32]($_.TotalSize / 1GB)}},
                    @{Name='Free(GB)'; Expr={[int32]($_.AvailableFreeSpace / 1GB)}},
                    @{Name='Free(%)';  Expr={[math]::Round($_.AvailableFreeSpace / $_.TotalSize,2)*100}},
                    @{Name='Format';   Expr={$_.DriveFormat}},
                    @{Name='Type';     Expr={[string]$_.DriveType}},
                    @{Name='Computer'; Expr={$ComputerName}}


                    #Set-ExecutionPolicy Unrestricted
$computerName = "etr-vpn-03"
$User = "ETR\svg"
$PWord = ConvertTo-SecureString -String "Pjjnt[ybrfDRdflhfnt#01" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord

Invoke-Command -ScriptBlock {



    $result = New-Object -TypeName PSObject
    $IPadd = '123.123.123.123'
    $StartTime1 = (Get-Date).AddMinutes(-20).ToString('MM/dd/yyyy HH:mm:ss')
    $StartTime2 = (Get-Date).addHours(-400).ToString('MM/dd/yyyy HH:mm:ss')
    $Now = Get-Date -Format "MM/dd/yyyy HH:mm:ss"
    $stat1 = Get-RemoteAccessConnectionStatistics -StartDateTime $StartTime1 -EndDateTime $Now | Select-Object * 
    $one = $stat1 | Select-Object -First 1

    $activity = Get-RemoteAccessUserActivity -StartDateTime $one.ConnectionStartTime -EndDateTime $one.ConnectionStartTime.AddSeconds($one.ConnectionDuration) -UserName $one.UserName
    $one
    $myObject = [PSCustomObject]@{}
    $myObject = [pscustomobject]::@{Name1 = Value1; Name2 = Value2; Name3 = Value3}
    $activity | ForEach-Object {
        $myObject | Add-Member -MemberType NoteProperty -Name 'ConnectionStartTime' -Value $one.ConnectionStartTime 
        $myObject | Add-Member -MemberType NoteProperty -Name 'SessionID' -Value $one.SessionId 
        $myObject | Add-Member -MemberType NoteProperty -Name 'UserName' -Value $one.UserName
        $myObject | Add-Member -MemberType NoteProperty -Name 'TunnelType' -Value $one.TunnelType
        $myObject | Add-Member -MemberType NoteProperty -Name 'ClientIPAddress' -Value $one.ClientIPAddress
        $myObject | Add-Member -MemberType NoteProperty -Name 'ClientExternalAddress' -Value $one.ClientExternalAddress
        $myObject | Add-Member -MemberType NoteProperty -Name 'ConnectionDuration' -Value $one.ConnectionDuration
        $myObject | Add-Member -MemberType NoteProperty -Name 'TotalBytesIn' -Value $one.TotalBytesIn
        $myObject | Add-Member -MemberType NoteProperty -Name 'IPadd' -Value $_.ServerIpAddress
        
    }
    $myObject | Select-Object *



 


} -ComputerName $computerName -Credential $Credential


    
