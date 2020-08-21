# Monitor Printers with a Temporary Event Subscription

## Original Links

- [x] Original Technet URL [Monitor Printers with a Temporary Event Subscription](https://gallery.technet.microsoft.com/7cc0c8f9-8e0e-4482-867c-10c8e4094d1f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/7cc0c8f9-8e0e-4482-867c-10c8e4094d1f/description)
- [x] Download: Not available.

## Output from Technet Gallery

Uses a temporary event consumer to issues alerts any time a printer changes status.

Visual Basic

```
strComputer = "."
Set objWMIService = GetObject("winmgmts:" _
    & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colPrinters = objWMIService. _ 
    ExecNotificationQuery("Select * from __instancemodificationevent " _ 
        & "within 30 where TargetInstance isa 'Win32_Printer'")
i = 0

Do While i = 0
    Set objPrinter = colPrinters.NextEvent
    If objPrinter.TargetInstance.PrinterStatus <> _ 
        objPrinter.PreviousInstance.PrinterStatus Then
        Select Case objPrinter.TargetInstance.PrinterStatus
            Case 1 strCurrentState = "Other" 
            Case 2 strCurrentState = "Unknown" 
            Case 3 strCurrentState = "Idle" 
            Case 4 strCurrentState = "Printing" 
            Case 5 strCurrentState = "Warming Up" 
        End Select
        Select Case objPrinter.PreviousInstance.PrinterStatus
            Case 1 strPreviousState = "Other" 
            Case 2 strPreviousState = "Unknown" 
            Case 3 strPreviousState = "Idle" 
            Case 4 strPreviousState = "Printing" 
            Case 5 strPreviousState = "Warming Up" 
        End Select
        Wscript.Echo objPrinter.TargetInstance.Name _ 
            &  " is " & strCurrentState _
                & ". The printer previously was " & strPreviousState & "."
    End If
Loop
```

