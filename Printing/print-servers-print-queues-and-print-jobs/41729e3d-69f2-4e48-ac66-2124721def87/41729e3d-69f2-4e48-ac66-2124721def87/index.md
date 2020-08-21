# Monitor the Print Servi

## Original Links

- [x] Original Technet URL [Monitor the Print Servi](https://gallery.technet.microsoft.com/41729e3d-69f2-4e48-ac66-2124721def87)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/41729e3d-69f2-4e48-ac66-2124721def87/description)
- [x] Download: Not available.

## Output from Technet Gallery

Returns the status of the Spooler service (running, stopped, paused, etc.).

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colRunningServices =  objWMIService.ExecQuery _
    ("Select * from Win32_Service Where Name = 'Spooler'")

For Each objService in colRunningServices 
    Wscript.Echo objService.DisplayName & " -- " & objService.State
Next
```

