#Set-ExecutionPolicy Unrestricted

[string[]]$computerNames = Get-Content -Path 'C:\Script\comps.txt'

function office_version {
    $paths = @(
        "HKLM:\SOFTWARE\Microsoft\Office\ClickToRun",
        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Office\ClickToRun"
    )
    $officeVersion = ""
    foreach ($path in $paths) {
        # Check to see if path exists
        if (Test-Path -Path "$path\Configuration") {
            $officeVersion = (Get-ItemProperty -Path "$path\Configuration" -Name "VersionToReport").VersionToReport
        }
    }
    return $officeVersion
}

$User = ".\Administrator"
$PWord = ConvertTo-SecureString -String "Teupotik9" -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $User, $PWord


foreach ( $computerName in $computerNames ) {
    Write-Output $computername
    $test_connection = Test-Connection -ComputerName $computerName -Quiet
    if ( $test_connection ) {   
        Invoke-Command -ComputerName $computerName -ScriptBlock {
            Set-ExecutionPolicy Unrestricted
            $hostname = hostname
            $current_build = "16.0.10396.20023"
            $result = @()
            $before = office_version
            if ($before -eq $current_build) {
                $result = $hostname + "`n" + "Current version: " + $before + "`n" + "No update required"
                $result
            }
            else {
                Start-Process -FilePath "C:\Program Files\Common Files\microsoft shared\ClickToRun\OfficeC2RClient.exe" -ArgumentList "/update", "user", "displaylevel=false" -Wait
                $after = office_version
                $result = $hostname + "`n" + "Current version: " + $before + "`n" + "Office updated to version " + $after + "`n"
                $result
            }
        } -Credential $Credential
    }
    else {
        Write-Output "$computername is unreacheble"
        Write-Output " "
    }
}

