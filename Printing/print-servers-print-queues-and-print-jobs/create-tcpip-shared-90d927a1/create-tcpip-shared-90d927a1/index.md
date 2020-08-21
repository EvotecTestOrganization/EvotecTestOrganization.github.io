# Create TCPIP Shared Printer and Por

## Original Links

- [x] Original Technet URL [Create TCPIP Shared Printer and Por](https://gallery.technet.microsoft.com/Create-TCPIP-Shared-90d927a1)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Create-TCPIP-Shared-90d927a1/description)
- [x] Download: Not available.

## Output from Technet Gallery

Reworked older VBS file that creates printer ports from file.  This will recreate a port or printer of the same name even if it already exists.

 This script outputs information toe two places 'stdout' and 'stderr'.  StdOut is useful for logging the exact settings of the created ports on a tab delimited format that can be opened in a spreadsheet.

StdErr contains ad-hoc messages

Visual Basic

```
'==========================================================================
'
' VBScript Source File -- Created with SAPIEN Technologies PrimalScript 2011
'
' NAME: InstallRCPIPPrinter.vbs
'
' AUTHOR: James Vierra , DSS
' DATE  : 5/26/2012
'
' COMMENT: Reworked older VBS file that creates printer ports from file.
'          This will recreate a port or printer of teh samee name even if it
'          already exists.
'
' TESTED: W2K, WS2003, XP
' Pipe delimited file
' Example:
'         PrinterIP|PortNumber|DriverName|ShareName|Location
'         169.254.110.160|9100|HP LaserJet 4000 Series PS|MyNewPrinter|USA/NYC/MyDept
'==========================================================================
Const INFILE="printers.txt"
Set fso=CreateObject("Scripting.FileSystemObject")
Set file = fso.OpenTextFile(INFILE)
While Not file.AtEndOfStream
    line = file.ReadLine()
    rec=Split(line,"|")
    InstallPrinter rec(0), rec(1), rec(2),rec(3),rec(4)
Wend
Function InstallPrinter( strPrinterIP, strPortNumber, strDriverName, strShareName, strLocation )
    Set wmi = GetObject("winmgmts:{impersonationLevel=impersonate}!\\.\root\cimv2")
    With wmi.Get("Win32_TCPIPPrinterPort").SpawnInstance_
        .Name        = "IP_" & strPrinterIP
        .Protocol    = 1
        .HostAddress = strPrinterIP
        .PortNumber  = strPortNumber
        ret=.Put_()
        WScript.StdErr.WriteLine "Port created:" & ret
    End With
    With wmi.Get("Win32_Printer").SpawnInstance_
        .DriverName = strDriverName
        .PortName   = "IP_" & strPortIP
        .DeviceID   = strShareName
        .Location   = strLocation
        .Network    = True
        .Shared     = True
        .ShareName  = strShareName
        ert=.Put_()
        WScript.StdErr.WriteLine "Printer created:" & ret
    End With
    WScript.Echo Now,"INSTALLED", strPrinterIP, strPortNumber, strDriverName, strShareName, strLocation
End Function
```

