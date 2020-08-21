# Install Printer Ports

## Original Links

- [x] Original Technet URL [Install Printer Ports](https://gallery.technet.microsoft.com/5777dc6a-9783-43d7-ac8e-fd3bd739690c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/5777dc6a-9783-43d7-ac8e-fd3bd739690c/description)
- [x] Download: Not available.

## Output from Technet Gallery

Installs a TCP/IP printer port on a computer.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")
Set objNewPort = objWMIService.Get _
    ("Win32_TCPIPPrinterPort").SpawnInstance_

objNewPort.Name = "IP_169.254.110.14"
objNewPort.Protocol = 1
objNewPort.HostAddress = "169.254.110.14"
objNewPort.PortNumber = "9999"
objNewPort.SNMPEnabled = False
objNewPort.Put_
```

