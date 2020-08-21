# Printers Inventory

## Original Links

- [x] Original Technet URL [Printers Inventory](https://gallery.technet.microsoft.com/Printers-Inventory-c83748c6)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Printers-Inventory-c83748c6/description)
- [x] Download: [Download Link](Download\Printer_Inventory.ps1)

## Output from Technet Gallery

@===Printer Inventory===@

This script build to collect Printer details from local, remote or Printer server.Which gives us - Print Server,Printer Name,Port Name,Share Name,Driver Name,Driver Version,Driver,Location,Shared -Details

Based on user inputs machine name will be taken.

@===Amol===@

Code from main script ------

```
ForEach ($Printserver in $Printservers)
{   $Printers = Get-WmiObject Win32_Printer -ComputerName $Printserver
    ForEach ($Printer in $Printers)
    {
        if ($Printer.Name -notlike "Microsoft XPS*")
        {
            $Sheet.Cells.Item($intRow, 1) = $Printserver
            $Sheet.Cells.Item($intRow, 2) = $Printer.Name
        If ($Printer.PortName -notlike "*\*")
            {   $Ports = Get-WmiObject Win32_TcpIpPrinterPort -Filter "name = '$($Printer.Portname)'" -ComputerName $Printserver
                ForEach ($Port in $Ports)
                {
                    $Sheet.Cells.Item($intRow, 3) = $Port.HostAddress
                }
            }
            $Sheet.Cells.Item($intRow, 4) = $Printer.ShareName
            $Sheet.Cells.Item($intRow, 5) = $Printer.DriverName
            ####################
```

