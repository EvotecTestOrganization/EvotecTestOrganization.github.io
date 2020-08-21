# PS Add Printer Por

## Original Links

- [x] Original Technet URL [PS Add Printer Por](https://gallery.technet.microsoft.com/fc636246-c4a4-4aa1-b25d-ce2449b28a05)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/fc636246-c4a4-4aa1-b25d-ce2449b28a05/description)
- [x] Download: Not available.

## Output from Technet Gallery

This script adds a TCP / IP Printer port

```
# ------------------------------------------------------------------------
# NAME: AddPrinterPort.ps1
# AUTHOR: ed wilson, Microsoft
# DATE: 10/23/2009
#
# KEYWORDS: wmi, printing, printer ports and printer drivers
#
# COMMENTS: This script uses the wmi class accelerator
# to create a new tcp / ip printer port on a local comptuer.
# To use you will need to modify the ip address of the port
#
# ------------------------------------------------------------------------
$ip = "10.0.0.10"
$port = [wmiclass]"Win32_TcpIpPrinterPort"
$port.psbase.scope.options.EnablePrivileges = $true
$newPort = $port.CreateInstance()
$newport.name = "IP_$ip"
$newport.Protocol = 1
$newport.HostAddress = $ip
$newport.PortNumber = "9100"
$newport.SnmpEnabled = $false
$newport.Put()
```

