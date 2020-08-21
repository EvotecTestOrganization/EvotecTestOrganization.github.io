# Set/Replace a Printer Driver on Print Queues on local or remote Computer.

## Original Links

- [x] Original Technet URL [Set/Replace a Printer Driver on Print Queues on local or remote Computer.](https://gallery.technet.microsoft.com/SetReplace-a-Printer-61ee0b1c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/SetReplace-a-Printer-61ee0b1c/description)
- [x] Download: [Download Link](Download\Set-LHSPrinterDriver.ps1)

## Output from Technet Gallery

Set/Replace a Printer Driver on Print Queues on local or remote Computer.

The Printer Drivers must be installed, This Function is not going to install Printer Drivers.

 Printers that do not replay to ping will be skipped.

The advanced Function supports -whatif and -confirm

.PARAMETER ComputerName

     The computer name(s) to where you want to set\change Print Drivers.

     Default to local Computer

 .PARAMETER PrinterName

     [Optional] The Printer Name you want to set\change the Print Driver.

     You can use the Asterix '\*' as wildcard to set\change Printer Drivers on a set of Printers.

     Default is '\*' - All Printers.

 .PARAMETER OldDriverName

     [Optional] Used to filter for Printers which have the given Driver Name as the current Print Driver Name.

     Use this Parameter if you want to replace Print Drivers on all Printers that uses

     the given Driver Name.

 .PARAMETER NewDriverName

     The Print Driver Name of an existing(installed) Driver that you want to set for the given Printers.

 .PARAMETER Force

     [Optional] Used for the ShouldProcess, Shouldcontinue.

     To override these confirmations use    -Confirm:$false or the -Force parameter.

     More Info:

     The variable: $ConfirmPreference default is 'High' and you should not change that.

     If the User selected -Confirm, has the effect that $Global:ConfirmPreference is set to Low.

     You can declare the impact of the commands on the system: "HIGH", "MEDIUM", "LOW".

[cmdletbinding(ConfirmImpact = 'High', SupportsShouldProcess = $True)]

     You can then set ConfirmImpact to be the level that you want Automatic confirmation turned on.

     When the ConfirmImpact is less than the $ConfirmPreference than only when you pass the

     Switch -Confirm the user will be prompted to confirm. If you want allways the user has to confirm

     even whith the -Force Parameter used, then set the ConfirmImpact  = 'High'

```
.EXAMPLE
    Set-LHSPrinterDriver -ComputerName Server1 -OldDriverName 'RICOH Aficio MP C2550 PCL 5c' -NewDriverName 'RICOH Aficio MP C3300 PCL 6' -WhatIf
    Connects to Server1 and replaces on all Printers which have Printer Driver 'RICOH Aficio MP C2550 PCL 5c' to
    'RICOH Aficio MP C3300 PCL 6'. The -Whatif Parameter will not make any changes but will show what will be done.
.EXAMPLE
    Set-LHSPrinterDriver -ComputerName Server1 -PrinterName "Test*" -NewDriverName 'RICOH Aficio MP C3300 PCL 6' -Force
    Connects to Server1 and will set on all Printers with Name beginning with Test (wildcard support) to the new Print Driver.
    The -Force Switch is to bypass the confirmation.
.EXAMPLE
    # check the number of Print Queues with Driver = 'HP Universal Printing PCL 6'
    $p = Get-Wmiobject -Class win32_printer -ComputerName server1 -Filter "DriverName like 'HP Universal Printing PCL 6'"
    $p.count
    # create a filename after ISO 8601 standard sortable date time-stamp
    $dt = (Get-Date).ToString("s").Replace(":","-")
    Set-LHSPrinterDriver -ComputerName server1 -OldDriverName 'HP Universal Printing PCL 6' -NewDriverName 'HP Universal Printing PCL 6 (v5.6.5)' *>&1 |
    Out-File -FilePath "C:\Temp\log\$dt.txt"
    will replace Printer Driver on Print queues of server1 that have the current Print Driver 'HP Universal Printing PCL 6'
    and replaces with 'HP Universal Printing PCL 6 (v5.6.5)'.
    '*>&1' is to redirect all outputs(verbose,warning,error,debug) to the standard output (requires PS V3.0 or higher).
    We pipe the output then to a file.
```

