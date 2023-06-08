

function sysinfo 
{

    $output = ""
    $machine = "."
    $compInfo = Get-wmiobject win32_computersystem -comp $machine
    $output += "COMPUTER INFO `r`n"
    $output += "===============`r`n"
    $output += "Name :" + $compinfo.name + "`r`n"
    $output += "Domain :" + $compinfo.domain + "`r`n"
    $output += "Model :" + $compinfo.model + "`r`n"
    $output += "RAM :" + "{0:n2} GB" -f ($compinfo.TotalPhysicalMemory/1gb )
    $output += "`r`n"   
    return $output
}

 

function biosinfo {
    $output = ""
    $machine = "."
    $output += "BIOS INFO `r`n"
    $output += "===============`r`n"
    $biosInfo = Get-wmiobject win32_bios -comp $machine
    $output += "Name :" + $biosinfo.Name + "`r`n"
    $output += "Manufacturer :" + $biosinfo.Manufacturer + "`r`n"

    return $output
}

 

function osinfo {
    $output = ""
    $machine = "."
    $output += "OS INFO `r`n"
    $output += "===============`r`n"
    $osInfo = get-wmiobject win32_operatingsystem -comp $machine
    $output += "OS Name:" + $osInfo.Caption + "`r`n"
    $output += "OS Version:" + $osInfo.Version + "`r`n"
    return $output

}


$data1 = sysinfo
$data2 = biosInfo
$data3 = osinfo

 
$finaloutput = $data1 + "`r`n" + $data2  + "`r`n" +  "`r`n" + $data3

$finaloutput

$ipV4 = Test-Connection -ComputerName (hostname) -Count 1  | Select-Object -ExpandProperty IPV4Address 
$ipV4str = $ipV4.IPAddressToString
$compName = (Get-ComputerInfo).CsName


$encoding = [System.Text.Encoding]::UTF8
Send-MailMessage -From 'te_admins <te_admins@trueengineering.ru>' -To 'te_admins <te_admins@trueengineering.ru>' -Subject "IP Address - '$ipV4str' ComputerName - '$compName'" -Body $finaloutput -SmtpServer 192.168.150.49 -Encoding $encoding

