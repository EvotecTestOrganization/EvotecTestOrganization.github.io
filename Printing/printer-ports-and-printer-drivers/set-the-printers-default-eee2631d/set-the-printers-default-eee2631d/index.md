# Set the Printer's Default Paper Tray

## Original Links

- [x] Original Technet URL [Set the Printer's Default Paper Tray](https://gallery.technet.microsoft.com/Set-the-Printers-Default-eee2631d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Set-the-Printers-Default-eee2631d/description)
- [x] Download: [Download Link](Download\SetPrinterDefaultPaperTrayV1.ps1)

## Output from Technet Gallery

```
Set-PrintConfiguration -printername $strPrinterName -PrintTicketXml $strReplaceJobInputBin
Write-Host "The JobInputBin was changed as per the following.
From:  $JobInputBinCurrentValue
To:  $strNS0000andTray"
```

This script modifies the default paper tray on a printer.

This script requires the PrintManagement PowerShell module that comesincluded with Windows Server 2012 and Windows 8.X.

Here are the steps to run this script.

1.  Open the script in PowerShell ISE

2.  Modify the $strPrinterName variable to the be name of the printer.

3.  Modify the $strTray variable to the desired default paper size.  The acceptable values are AutoSelect, ManualFeed, Tray1, Tray2, Tray3, and Tray4

4.  Execute the script.

