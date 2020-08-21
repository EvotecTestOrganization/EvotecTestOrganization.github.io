# Printer info Lookup

## Original Links

- [x] Original Technet URL [Printer info Lookup](https://gallery.technet.microsoft.com/Printer-info-Lookup-d3340c8b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Printer-info-Lookup-d3340c8b/description)
- [x] Download: [Download Link](Download\PrinterInfo.ps1)

## Output from Technet Gallery

```
$name = Read-Host "Please Enter Printer Name you are searching for"
$PrintServList = 'Your Print Server Name Goes Here' #Change this field
ForEach ($PrintSrv in $PrintServList)
{
    if ((Test-Connection -computername $PrintSrv -Count 2 -Quiet) -eq $true)
    {
        Write-Host "Looking for Printer info on $PrintSrv"
        $Action = Get-WmiObject Win32_Printer -ComputerName $PrintSrv -ErrorAction SilentlyContinue | Where-Object {$_.Name -eq $Name} | Select Name, SystemName, Location, Comment, DriverName | Format-Table -AutoSize
        If ((Get-WmiObject Win32_Printer -ComputerName $PrintSrv).name -eq $Name){$Action}
        Else {Write-host "   Printer Not Found on Server" -ForegroundColor Red}
    }
    Else {Write-Warning "Print Server $PrintSrv Down, Contact Network Admin!!!"}
}
Write-Host "The search is complete, press any key to exit"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
```

A Simple Powershell Script that allows the user to input a Printer Name and search for the printer information against Multiple print Servers. It also checks the status of the Print Server to warn a Technician there may be connectivity issues.

The Script is ran from a Technician's computer to be ran against multiple print servers. The information it reports is only as reliable as the information put into the Printer Description on the Print Server.

