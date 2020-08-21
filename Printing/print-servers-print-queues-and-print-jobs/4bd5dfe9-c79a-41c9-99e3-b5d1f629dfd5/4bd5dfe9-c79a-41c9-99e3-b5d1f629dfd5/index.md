# rminal Server 2008

## Original Links

- [x] Original Technet URL [rminal Server 2008](https://gallery.technet.microsoft.com/4bd5dfe9-c79a-41c9-99e3-b5d1f629dfd5)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/4bd5dfe9-c79a-41c9-99e3-b5d1f629dfd5/description)
- [x] Download: Not available.

## Output from Technet Gallery

In TS 2008 if your print spooler crash all of your redirected printer goes offline. This script take ownership and security of those printers and bring those printers online. Run it from SYSTEM account

----------------------------------------------------------------

net stop spooler

 del /q %systemroot%\system32\spool\printers\\*.\*

 net start spooler

 subinacl /printer \* /setowner=administrators

 subinacl /printer \* /grant="Print Operators"

 cscript makeonline.vbs

-----------------------------------------------------------------

Visual Basic

```
option explicit
const kNameSpace               = "root\cimv2"
dim strServer
dim strUser
dim strPassword
dim Printers
dim oService
dim oPrinter
dim iTotal
if WmiConnect(strServer, kNameSpace, strUser, strPassword, oService) then     set Printers = oService.InstancesOf("Win32_Printer")
    	iTotal = 0
for each oPrinter in Printers
        	iTotal = iTotal + 1	if oPrinter.Workoffline=-1 then		oPrinter.Workoffline=0		oPrinter.Put_(1)	end ifnext
end if
function WmiConnect(strServer,  strNameSpace, strUser, strPassword, oService)
    on error resume next
    dim oLocator
    dim bResult
    oService = null
    bResult  = false
    set oLocator = CreateObject("WbemScripting.SWbemLocator")
    if Err = kErrorSuccess then
        set oService = oLocator.ConnectServer(strServer, strNameSpace, strUser, strPassword)
        if Err = kErrorSuccess then
            bResult = true
            oService.Security_.impersonationlevel = 3
            oService.Security_.Privileges.AddAsString "SeLoadDriverPrivilege"
            Err.Clear
        end if
    end if
    WmiConnect = bResult
end function
```

