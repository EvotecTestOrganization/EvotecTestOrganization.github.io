# Printers on Print Server Repor

## Original Links

- [x] Original Technet URL [Printers on Print Server Repor](https://gallery.technet.microsoft.com/Printers-on-Print-Server-10a36018)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Printers-on-Print-Server-10a36018/description)
- [x] Download: [Download Link](Download\PrinterReport-Server.ps1)

## Output from Technet Gallery

A simple script to run against a networks Print Server(s) and generates a CSV format report of what printers are installed on that print server, the location, Comments, and Driver Name. You can add in PortName in the selection section and it should return  the IP Address if someone has not changed the name from the IP Address to the Printer Name, which is what was done in my enviroment I am working in. It is intended to be ran from a technician's computer to a remote print server and can be ran against multiple  print servers with out adding more code.

At $PrintSrvList tha is where you will put in the desired print servers or you can modify the code to Import-CSV files.

```
$new = Get-Date -Format MMM.dd.yyyy.hh.mm
$PrintSrvList = 'Put Printers Servers Here' #Change this field
ForEach ($PRTSrv in $PrintSrvList)
{
    if ((Test-Connection -computername $PRTSrv -Count 2 -Quiet) -eq $true)
    {
        Write-Host "Looking for Printer info on $PRTSrv"
        Get-WmiObject Win32_Printer -ComputerName $PRTSrv -ErrorAction SilentlyContinue | Select Name, SystemName, Location, Comment, DriverName | Export-Csv .\Printers-Server.$new.csv -Append
    }
    Else {Write-Warning "Print Server $PRTSrv Down, Contact Network Admin!!!"}
}
Write-Host "The search is complete, press any key to exit"
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
```

