# Purge a Print Queu

## Original Links

- [x] Original Technet URL [Purge a Print Queu](https://gallery.technet.microsoft.com/d222eb9a-51ee-443c-972d-d15ffb6d87ba)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/d222eb9a-51ee-443c-972d-d15ffb6d87ba/description)
- [x] Download: Not available.

## Output from Technet Gallery

Deletes all the print jobs for a printer named HP QuietJet.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colInstalledPrinters =  objWMIService.ExecQuery _
    ("Select * from Win32_Printer Where Name = 'HP QuietJet'")

For Each objPrinter in colInstalledPrinters
    objPrinter.CancelAllJobs()
Next
```

