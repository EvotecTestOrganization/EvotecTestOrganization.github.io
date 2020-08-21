# Write Printer Information to a Web Pag

## Original Links

- [x] Original Technet URL [Write Printer Information to a Web Pag](https://gallery.technet.microsoft.com/ef4da3ce-7075-46b6-98a2-b49c94743048)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/ef4da3ce-7075-46b6-98a2-b49c94743048/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Jesse Riley

Exports printer information to a Web page.

Visual Basic

```
'****** re-used html needed later ******
'top listing
list = "<td><font size=" & chr(34) & "2" & chr(34) & _">Network Name</font></td><td><font size=" & chr(34) & "2" & chr(34) & _
        ">IP Address</font></td><td><font size=" & chr(34) & "2" & chr(34) & _">Model</font></td><td><font size=" & chr(34) & "2" & chr(34) & _">Comments</font></td><td><font size=" & chr(34) & "2" & chr(34) & _">Share Name</font></td></tr>"

'td open close
tco = "</font></td><td><font size=" & chr(34) & "2" & chr(34) & ">"

'open table
opentable = "<tr><td><font size=" & chr(34) & "2" & chr(34) & ">"

'close table
closetable = "</font></td></tr>"

'*************

strcomputer = "."

Set objFSO = CreateObject("Scripting.FileSystemObject")
'change C:\printers.htm to whatever you wish
Set File = objFSO.CreateTextFile("C:\printers.htm", True)


Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & _
    strComputer & "\root\cimv2")
Set colInstalledPrinters = objWMIService.ExecQuery ("Select * from Win32_Printer")

'-----------------------------------------------------------------
file.writeline "<html><head><title>Printer Inventory</title>"
file.writeline "</head>"
file.writeline "<body><table border=" & chr(34) & "0" & chr(34) & "width=" & chr(34) & _
    "1000" & chr(34) & "id=" & chr(34) & "table1" & chr(34) & ">" & list 

For Each objPrinter in colInstalledPrintersname = objprinter.namecomment = objprinter.commentsharename = objprinter.sharenameport = objprinter.portnamedrivername = objprinter.drivernamefile.writeline opentable & name & tco & port & tco & drivername & tco & _
    comment & tco & ShareName & closetable
Next

file.writeline "</font></table></body></html>"

File.Close
```

