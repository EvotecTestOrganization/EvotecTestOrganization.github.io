# Powershell script to change printer IP address

## Original Links

- [x] Original Technet URL [Powershell script to change printer IP address](https://gallery.technet.microsoft.com/Powershell-script-to-69903f6c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Powershell-script-to-69903f6c/description)
- [x] Download: [Download Link](Download\Change-PrinterIP.ps1)

## Output from Technet Gallery

This Powershell script changes printer IP address

It requires 2 parameters:

OldIP  Example: 192.168.0.99    and

NewIP  Example: 192.168.0.95

```
<#
 .Synopsis
  Script to change printer IP address
 .Description
  This script changes printer IP address
  It leaves a log file in the current folder that lists script progress
 .Parameter OldIP
  Example: 192.168.0.99
 .Parameter NewIP
  Example: 192.168.0.95
 .Example
   .\Change-PrinterIP.ps1 192.168.0.99 192.168.0.95
   This example changes the printer attached to the print port with IP 192.168.0.99
   It creates a new printer port with same settings as the old 192.168.0.99 printer port,
   assigns the printer to the new port, and deletes the old printer port
 .Link
  https://superwidgets.wordpress.com/category/powershell/
 .Notes
  v1.0 - 07/27/2014
#>
#==============================================================================
# Script Name:        Change-PrinterIP.ps1
# DATE:               07/27/2014
# Version:            1.0
# COMMENT:            Script to change printer IP address
#==============================================================================
#
```

.\Change-PrinterIP.ps1 192.168.0.99 192.168.0.95   This example changes the printer attached to the print port with IP 192.168.0.99   It creates a new printer port with same settings as the old 192.168.0.99 printer port,   assigns  the printer to the new port, and deletes the old printer port

It leaves a log file in the current folder that lists script progress

For more information see https://superwidgets.wordpress.com/category/powershell/

v1.0 - 07/27/2014

Script output looks like:

![](Images\change-printerip.jpg)

