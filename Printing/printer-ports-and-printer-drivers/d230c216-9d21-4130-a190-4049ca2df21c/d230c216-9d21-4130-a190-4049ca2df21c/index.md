# Add Printer

## Original Links

- [x] Original Technet URL [Add Printer](https://gallery.technet.microsoft.com/d230c216-9d21-4130-a190-4049ca2df21c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/d230c216-9d21-4130-a190-4049ca2df21c/description)
- [x] Download: Not available.

## Output from Technet Gallery

&lt;html xmlns=""&gt;

This script uses the [wmiclass] type accelerator which createsan instance of the System.Management.ManagementClass which

gives access to createInstance() method. The Dot Net framework class system.management.managementclass is needed so we canuse the equilivant to the spawninstance method from vbscript

```
# --------------------------------------------------------------------
# createPrinterPort.ps1
# ed wilson 3/24/2008
#
# uses [wmiclass] type accelerator which creates
# an instance of the System.Management.ManagementClass which
# gives access to createInstance() method. The Dot Net framework
# class system.management.managementclass is needed so we can
# use the equilivant to the spawninstance method from vbscript
# we need to add special privileges, to do this we use the psbase
# object and specify the scope.options.enableprivileges
# this is placed on our management class object
# all the properties below must be specified, or the command will
# fail. Interestingly enough, the script does not need to run with
# admin rights on vista.
#
# ** strangely enough, it seems that enablePrivileges is NOT required
# for this script... IT SHOULD be required however, as the loadDriver
# privilege is required, and should not be obtained by default...
# Make sure you modify default values below.
# --------------------------------------------------------------------
$hostAddress = "111.111.111.111"
$portNumber = "9100"
$computer = "hyperv-box"
$wmi= [wmiclass]"\\$computer\root\cimv2:win32_tcpipPrinterPort"
#$wmi.psbase.scope.options.enablePrivileges = $true
$newPort = $wmi.createInstance()
$newPort.hostAddress = $hostAddress
$newPort.name = "IP_" + $hostAddress
$newPort.portNumber = $portNumber
$newPort.SNMPEnabled = $false
$newPort.Protocol = 1
$newPort.put()
```

