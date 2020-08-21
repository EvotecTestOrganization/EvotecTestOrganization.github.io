# Install a TCP/IP Printer Port and Printer

## Original Links

- [x] Original Technet URL [Install a TCP/IP Printer Port and Printer](https://gallery.technet.microsoft.com/41a4c996-b7f7-4d58-808d-2acac20ddbf7)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/41a4c996-b7f7-4d58-808d-2acac20ddbf7/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Gamer

Installs a TCP/IP printer port, installs a printer, and then sets the printer to be default. As written the script installs a Brother printer, but you can substitute any printer driver as long as it's in the driver cache.

Visual Basic

```
On Error Resume Next

'SETS 'LOAD DRIVER' PRIVILEGE.


    Set objWMIService = GetObject("Winmgmts:")

    objWMIService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege", True


'SETS PRINTER PORT.


    Set objNewPort = objWMIService.Get _
        ("Win32_TCPIPPrinterPort").SpawnInstance_

    objNewPort.Name = "Brother"

    objNewPort.Protocol = 1

    objNewPort.HostAddress = "192.168.100.7"

    objNewPort.PortNumber = "9100"

    objNewPort.SNMPEnabled = False

    objNewPort.Put_


'SETS PRINTER TO PORT.


    Set objPrinter = objWMIService.Get _
        ("Win32_Printer").SpawnInstance_

    objPrinter.DriverName = "Brother HL-1270N"

    objPrinter.PortName   = "Brother"

    objPrinter.DeviceID   = "Brother HL-1270N"

    objPrinter.Location = "Front Office"

    objPrinter.Network = True

    objPrinter.Shared = False

    'objPrinter.ShareName =

    objPrinter.Put_


'SETS PRINTER AS DEFAULT.


    Set colInstalledPrinters =  objWMIService.ExecQuery _
        ("Select * from Win32_Printer Where Name = 'Brother HL-1270N'")

    For Each objPrinter in colInstalledPrinters
        objPrinter.SetDefaultPrinter()

    next
```

