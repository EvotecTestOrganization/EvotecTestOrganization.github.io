# Delete Printer Connection

## Original Links

- [x] Original Technet URL [Delete Printer Connection](https://gallery.technet.microsoft.com/efce5116-c83d-4770-af61-0e095e04f3e0)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/efce5116-c83d-4770-af61-0e095e04f3e0/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Anonymous Submission

Deletes a printer connection on logoff.

Visual Basic

```
dim oMaster
dim oPrinter

set oMaster  = CreateObject("PrintMaster.PrintMaster.1")
set oPrinter = CreateObject("Printer.Printer.1")

oPrinter.ServerName  = ""
oPrinter.PrinterName = "Lexmark E332n"

oMaster.PrinterDel oPrinter

if Err <> 0 then'An error occurred
end if
```

