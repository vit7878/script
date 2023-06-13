$pp = Find-Package -Source https://nuget-01.eastbanctech.ru/gallery/api/v2/ -AllVersions
$LogUnsuccessful = "C:\Log\Unsuccessful.csv"
$LogSuccessful = "C:\Log\Successful.csv"
#$bb= $pp[2821..3711]
#foreach ($p in $bb)
foreach ($p in $pp)
{
    try {
        
        Install-Package -Name $p.Name -RequiredVersion $p.Version -Source https://nuget-02.eastbanctech.ru/api/v2 -Force -ErrorAction Stop
        $body = $p.Name + "`t" + $p.Version
        Out-File -File $LogSuccessful -InputObject $body -Append
    }
    catch {
        $body = $p.Name + "`t" + $p.Version
        Out-File -File $LogUnsuccessful  -InputObject $body -Append
    }
}
#-SkipDependencies - ключ для пропуска ошибок из за отсутсвия зависимостей.