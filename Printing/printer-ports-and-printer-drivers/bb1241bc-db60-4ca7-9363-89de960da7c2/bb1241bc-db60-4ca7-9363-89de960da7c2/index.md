# Add a Printer Using an INF Fil

## Original Links

- [x] Original Technet URL [Add a Printer Using an INF Fil](https://gallery.technet.microsoft.com/bb1241bc-db60-4ca7-9363-89de960da7c2)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/bb1241bc-db60-4ca7-9363-89de960da7c2/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **vbzine

Adds a printer and a TCP/IP printer port using information found in an INF file.

Visual Basic

```
Dim Computer, DriverName, DriverInf, IPAddress, PortName, PrinterName
Dim WMI, NewPort, NewDriver, NewPrinter

' Enter Details of Printer
' Computer on which to create the printer.
Computer = "."
' The printer driver's name.
DriverName = "Xerox Printer PS"
' The full path and filename of the .inf file.
DriverInf = "Z:\Printer Drivers\Xerox\oemsetup.inf"
' The printer's IP address.
IPAddress = "192.168.123.11"
' The printer's Name.
PrinterName = "PRT01-Xerox"
' End of Details entering

' The port name that will be created.
PortName = "IP_" & IPAddress

' Establish WMI connection to specified computer.
' Note that the loaddriver privilege is required to add the driver.
Set WMI = GetObject("winmgmts:{impersonationlevel=impersonate" _
  & ",(loaddriver)}!//" & Computer & "/root/cimv2")

' Step A: Install the printer's driver.
Set NewDriver = WMI.Get("Win32_PrinterDriver")
NewDriver.Name = DriverName
NewDriver.InfName = DriverInf
Result = NewDriver.AddPrinterDriver(NewDriver)

If Result = 0 Then
  WScript.Echo "Added printer driver: " & DriverName
Else
  WScript.Echo "Error " & Result & " adding printer driver: " & DriverName
  WScript.Quit
End If

' Step B: Create a TCP/IP printer port for the printer.
Set NewPort = WMI.Get("Win32_TCPIPPrinterPort").SpawnInstance_
NewPort.HostAddress = IPAddress
NewPort.Name = PortName
NewPort.Protocol = 1  ' 1 = Raw, 2 = LPR
NewPort.Put_

WScript.Echo "Created printer port: " & PortName

' Step C: Add the printer.
Set NewPrinter = WMI.Get("Win32_Printer").SpawnInstance_
NewPrinter.DriverName = DriverName
NewPrinter.DeviceID = PrinterName
NewPrinter.PortName = PortName
NewPrinter.Put_

WScript.Echo "Created printer: " & PrinterName
```

