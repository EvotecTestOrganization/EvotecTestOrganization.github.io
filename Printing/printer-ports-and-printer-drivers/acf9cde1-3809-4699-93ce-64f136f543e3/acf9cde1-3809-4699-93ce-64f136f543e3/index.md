# Select a New Default Printer

## Original Links

- [x] Original Technet URL [Select a New Default Printer](https://gallery.technet.microsoft.com/acf9cde1-3809-4699-93ce-64f136f543e3)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/acf9cde1-3809-4699-93ce-64f136f543e3/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Anonymous

This script finds all the printer connections on your computer and then allows you to choose a new default printer.

Visual Basic

```
strComputer = "."
strprinter = ""
nummer =1
Set objWMIService = GetObject("winmgmts:\\"  & strComputer & "\root\cimv2")
Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where Default = True")
For Each objPrinter in colInstalledPrinters
    WScript.echo objPrinter.name & " is your default printer!"
Next
Set colinstallprinters = objwmiservice.execquery("select * from Win32_printer")
For Each objprinters In colinstallprinters
    WScript.Echo objprinters.deviceid
    colname =colname & "(" & nummer &") " & objprinters.deviceid & "," & VbCrLf 
    nummer=1+nummer
    
    Next 
strprinter = InputBox (colname & "Välj ett nummer för att byta förvald skrivare")
ss=Split(colname,",")
valjskrivare = ss(strprinter-1)
hittavart = InStr (valjskrivare,")")
valjskrivare = Mid (valjskrivare,hittavart+2)
For Each objprinters In colinstallprinters
    If objprinters.deviceid = valjskrivare Then
        If objprinters.Default = "true" Then
            MsgBox (valjskrivare &" är satt som default")
        Else
            objprinters.setdefaultprinter
            MsgBox (valjskrivare &" är nu förvald som skrivare")
        End If
    End If
Next
```

