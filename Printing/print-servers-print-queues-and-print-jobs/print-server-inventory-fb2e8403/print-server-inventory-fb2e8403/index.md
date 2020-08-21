# Print Server Inventory

## Original Links

- [x] Original Technet URL [Print Server Inventory](https://gallery.technet.microsoft.com/Print-Server-Inventory-fb2e8403)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Print-Server-Inventory-fb2e8403/description)
- [x] Download: [Download Link](Download\PrintServerInventory.ps1)

## Output from Technet Gallery

This powershell script will allow you to create an excel file on you computer with the following information about the printers on any given server:

- Printer Name

- Location

- Comment

- IP Address

- Driver Name

- Shared

- Share Name

Please be aware that while running the script you must have administrator or power user rights on the print server. You also will not want to use the computer while running the script. If you accidently type into the excel document as it is completing the  script will fail. Also, if you have more that one print server as we do, you can just repeat the code below the first section of code for the new print server and it will run.

```
# Print server inventory script
# Set print server name
$Printserver = "PRINTSERVER"
# Create new Excel workbook
$Excel = new-Object -comobject Excel.Application
$Excel.visible = $True
$Excel = $Excel.Workbooks.Add()
$Sheet = $Excel.Worksheets.Item(1)
$Sheet.Cells.Item(1,1) = "Printer Name"
$Sheet.Cells.Item(1,2) = "Location"
$Sheet.Cells.Item(1,3) = "Comment"
$Sheet.Cells.Item(1,4) = "IP Address"
$Sheet.Cells.Item(1,5) = "Driver Name"
$Sheet.Cells.Item(1,6) = "Shared"
$Sheet.Cells.Item(1,7) = "Share Name"
$intRow = 2
$WorkBook = $Sheet.UsedRange
$WorkBook.Font.Bold = $True
# Get printer information
$Printers = Get-WMIObject Win32_Printer -computername $Printserver
foreach ($Printer in $Printers)
{
    $Sheet.Cells.Item($intRow, 1) = $Printer.Name
    $Sheet.Cells.Item($intRow, 2) = $Printer.Location
    $Sheet.Cells.Item($intRow, 3) = $Printer.Comment
    $Ports = Get-WmiObject Win32_TcpIpPrinterPort -computername $Printserver
        foreach ($Port in $Ports)
        {
            if ($Port.Name -eq $Printer.PortName)
            {
            $Sheet.Cells.Item($intRow, 4) = $Port.HostAddress
            }
        }
    $Sheet.Cells.Item($intRow, 5) = $Printer.DriverName
    $Sheet.Cells.Item($intRow, 6) = $Printer.Shared
    $Sheet.Cells.Item($intRow, 7) = $Printer.ShareName
    $intRow = $intRow + 1
}
$WorkBook.EntireColumn.AutoFit()
$intRow = $intRow + 1
$Sheet.Cells.Item($intRow,1).Font.Bold = $True
$Sheet.Cells.Item($intRow,1) = "Print server inventory"
```

