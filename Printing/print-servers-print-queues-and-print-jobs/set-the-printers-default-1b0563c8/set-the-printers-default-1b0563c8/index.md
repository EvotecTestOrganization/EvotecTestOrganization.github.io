# Set the Printer's Default Paper Siz

## Original Links

- [x] Original Technet URL [Set the Printer's Default Paper Siz](https://gallery.technet.microsoft.com/Set-the-Printers-Default-1b0563c8)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Set-the-Printers-Default-1b0563c8/description)
- [x] Download: [Download Link](Download\Get-PrintConfigurationAndSet-PrintConfigurationV1.ps1)

## Output from Technet Gallery

```
# Specify the printer name.
$strPrinterName = "PrinterName"
# Specify the desired paper size.  Acceptable values are letter, legal, A5, A4, etc ...
$strDesiredPaperSize = "A5"
$objPrinter = Get-PrintConfiguration -PrinterName $strPrinterName
$strPaperSize = $objPrinter.PaperSize
If ($strPaperSize -ne $strDesiredPaperSize)
    {
    Set-PrintConfiguration -PrinterName $strPrinterName -PaperSize $strDesiredPaperSize
    $objPrinter = Get-PrintConfiguration -PrinterName $strPrinterName
    $strPaperSizeUpdated = $objPrinter.PaperSize
    $strPaperSizeUpdated
    Write-Host "The paper size was changed as follows:
        From:  $strPaperSize
        To:  $strPaperSizeUpdated"
    }
    Else
    {
    Write-Host "The paper size was not changed because it was already set to $strDesiredPaperSize."
    }
```

This script sets the default paper size used by the printer.  It first checks to see if the paper size is already set to the desiredsize.  If yes, the paper size is not updated.  If no, the paper size is updated and the original and changed paper sizes are reported back tothe user.

This script requires the PrintManagement module that comesincluded with Windows Server 2012 and Windows 8.X.

Here are the steps to run this script.

1.  Open the script in PowerShell ISE

2.  Modify the $strPrinterName variable to be the name of the printer.

3.  Modify the $strDesiredPaperSize variable to the desired default paper size.

4.  Execute the script.

