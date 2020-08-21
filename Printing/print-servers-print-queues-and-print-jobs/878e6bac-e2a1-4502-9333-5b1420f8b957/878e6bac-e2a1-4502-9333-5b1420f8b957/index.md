# SetPrint.ps1

## Original Links

- [x] Original Technet URL [SetPrint.ps1](https://gallery.technet.microsoft.com/878e6bac-e2a1-4502-9333-5b1420f8b957)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/878e6bac-e2a1-4502-9333-5b1420f8b957/description)
- [x] Download: Not available.

## Output from Technet Gallery

## Description

A Powershell script to set some default settings on all the print queues on your print server. You can set the following settings: color, monochrome, twosided, singlesided, and staple. Use "show" to show the print queue properties.

---------------------------------------------------------------------------------------------------------------------------------

```
param ($ChangeProp)
$host.Runspace.ThreadOptions = "ReuseThread"
Add-Type -AssemblyName System.Printing
$permissions = [System.Printing.PrintSystemDesiredAccess]::AdministrateServer
$queueperms = [System.Printing.PrintSystemDesiredAccess]::AdministratePrinter
$server = new-object System.Printing.PrintServer -argumentList $permissions
$queues = $server.GetPrintQueues()
function SetProp($capability, $property, $enumeration)
    {
        if ($PrintCaps.$capability.Contains($property))
                            {
                              $q2.DefaultPrintTicket.$enumeration = $property
                              $q2.commit()
                                write-host ($q.Name +" is now configured for " + $property)
                                write-host (" ")
                             }
                        else
                            {
                                write-host ($q.Name +" does not support " + $property)
                                write-host (" ")
                            }
    }
try {
 foreach ($q in $queues)
        {
            #Get edit Permissions on the Queue
            $q2 = new-object System.Printing.PrintQueue -argumentList $server,$q.Name,1,$queueperms
            # Get Capabilities Object for the Print Queue
            $PrintCaps = $q2.GetPrintCapabilities()
            switch ($ChangeProp)
             {
                {$_ -eq "twosided"}
                    {
                       SetProp DuplexingCapability TwoSidedLongEdge Duplexing
                       break
                    }
                    {$_ -eq "onesided"}
                    {
                       SetProp DuplexingCapability onesided Duplexing
                       break
                    }
                    {$_ -eq "mono"}
                    {
                        SetProp OutputColorCapability monochrome OutputColor
                        break
                      }
                {$_ -eq "color"}
                    {
                        SetProp OutputColorCapability color OutputColor
                        break
                      }
                {$_ -eq "staple"}
                    {
                        SetProp StaplingCapability StapleTopLeft Stapling
                        break
                      }
                {$_ -eq "show"}
                    {
                        $DefaultTicket = $q2.DefaultPrintTicket
                        $TicketProps = $DefaultTicket | Get-Member -MemberType Property
                        write-host (" ")
                        write-host ($q.name)
                        foreach ($p in $TicketProps)
                        {
                         $PName = $p.name
                         $PropValue = $DefaultTicket.$PName
                         write-host ($p.name + " = " + $PropValue)
                        }
                      }
                default
                    {
                        Write-Host ("$_ is not a valid parameter")
                        exit
                    }
                }
        }
    }
catch [System.Management.Automation.RuntimeException]
 {
    write-host ("Exception: " + $_.Exception.GetType().FullName)
    write-host $_.Exception.Message
 }
```

