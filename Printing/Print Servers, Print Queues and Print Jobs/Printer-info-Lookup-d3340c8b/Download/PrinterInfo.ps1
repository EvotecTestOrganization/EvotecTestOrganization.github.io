$name = Read-Host "Please Enter Printer Name you are searching for"
$PrintServList = 'Your Print Server Name Goes Here' #Change this field
ForEach ($PrintSrv in $PrintServList)
{
    if ((Test-Connection -computername $PrintSrv -Count 2 -Quiet) -eq $true) 
    {
        Write-Host "Looking for Printer info on $PrintSrv"
        $Action = Get-WmiObject Win32_Printer -ComputerName $PrintSrv -ErrorAction SilentlyContinue | Where-Object {$_.Name -eq $Name} | Select Name, SystemName, Location, Comment, DriverName | Format-Table -AutoSize
        If ((Get-WmiObject Win32_Printer -ComputerName $PrintSrv).name -eq $Name){$Action}
        Else {Write-host "   Printer Not Found on Server" -ForegroundColor Red}
    }
    Else {Write-Warning "Print Server $PrintSrv Down, Contact Network Admin!!!"}
}

Write-Host "The search is complete, press any key to exit"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")