$new = Get-Date -Format MMM.dd.yyyy.hh.mm

$PrintSrvList = 'Put Printers Servers Here' #Change this field
ForEach ($PRTSrv in $PrintSrvList)
{
    if ((Test-Connection -computername $PRTSrv -Count 2 -Quiet) -eq $true) 
    {
        Write-Host "Looking for Printer info on $PRTSrv"
        Get-WmiObject Win32_Printer -ComputerName $PRTSrv -ErrorAction SilentlyContinue | Select Name, SystemName, Location, Comment, DriverName | Export-Csv .\Printers-Server.$new.csv -Append
    }
    Else {Write-Warning "Print Server $PRTSrv Down, Contact Network Admin!!!"}
}

Write-Host "The search is complete, press any key to exit"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")