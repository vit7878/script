$arrService = Get-Service -Name winlogbeat -ComputerName shakhov
if ( $arrService.Status -eq 'Running' )
{
    Write-Output "Install Winlogbeat application: OK"
}
else
{
    Write-Warning "Install Winlogbeat application: FALSE"
}