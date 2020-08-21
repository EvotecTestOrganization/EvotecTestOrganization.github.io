# PrintServerManagement.ps1

## Original Links

- [x] Original Technet URL [PrintServerManagement.ps1](https://gallery.technet.microsoft.com/PrintServerManagementps1-7676ed28)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/PrintServerManagementps1-7676ed28/description)
- [x] Download: [Download Link](Download\PrintServerManagement.ps1)

## Output from Technet Gallery

After a recent server upgrade I was disappointed to see a lack of PowerShell functions to handle printers. Specifically a lack of support for accessing printers in a clustered environment. After reading the very short list of posts from the [Microsoft Printing Team](http://blogs.technet.com/b/print/), I wrote up my own. The code is based on their [Printer Management post](http://blogs.technet.com/b/print/archive/2009/10/16/printer-management-using-powershell.aspx), I made some adjustments to it to handle accessing print queues on a remote server, as well as loading the GAC properly.

I had an issue on my x64 workstation where System.Print was giving me an error, you can read about it in the [post](http://blogs.technet.com/b/print/archive/2009/10/16/printer-management-using-powershell.aspx) I mentioned earlier. The only sure-fire way seemed to be loading the .dll directly and letting powershell handle everything for me.

I hope you enjoy them, they are quite handy I've come to rely on them quite a bit since writing them.

```
Function Get-Printers
{
    <#
    .SYNOPSIS
        Get a list of printers from the specified print server
    .DESCRIPTION
        This function returns the Name of each printer installed
        on the specified print server.
    .PARAMETER ComputerName
        Name of the print server
    .EXAMPLE
        Get-Printers -ComputerName ps
    .LINK
        https://code.google.com/p/mod-posh/wiki/PrintServerManagement#Get-Printers
    #>
    [CmdletBinding()]
    Param
        (
        [String]$ComputerName
        )
    Begin
    {
        $Host.Runspace.ThreadOptions = "ReuseThread"
        if ((Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture -eq '64-bit')
        {
            $SystemPrinting = Get-ChildItem "$($env:systemroot)\assembly\GAC_64\System.Printing"
            $SystemPrintingFile = Get-ChildItem -Name "*system.printing*" -Recurse -Path $SystemPrinting.FullName
            $SystemPrintingFile = "$($SystemPrinting.FullName)\$($SystemPrintingFile)"
            }
        else
        {
            $SystemPrinting = Get-ChildItem "$($env:systemroot)\assembly\GAC_32\System.Printing"
            $SystemPrintingFile = Get-ChildItem -Name "*system.printing*" -Recurse -Path $SystemPrinting.FullName
            $SystemPrintingFile = "$($SystemPrinting.FullName)\$($SystemPrintingFile)"
            }
        $ErrorActionPreference = "Stop"
        Try
        {
            Add-Type -Path $SystemPrintingFile
            $PrintServer = New-Object System.Printing.PrintServer("\\$($ComputerName)")
            $PrintQueues = $PrintServer.GetPrintQueues()
            }
        Catch
        {
            Write-Error $Error[0].Exception
            Break
            }
        $Printers = @()
        }
    Process
    {
        Foreach ($PrintQueue in $PrintQueues)
        {
            $ThisPrinter = New-Object -TypeName PSObject -Property @{
                Name = $PrintQueue.Name
                }
            $Printers += $ThisPrinter
            }
        }
    End
    {
        Return $Printers
        }
    }
Function Get-PrintQueue
{
    <#
    .SYNOPSIS
        Return the print queue for a given printer
    .DESCRIPTION
        This function returns the print queue for a specific printer
        from the print server.
    .PARAMETER ComputerName
        Name of the print server
    .PARAMETER Name
        Name of the print queue
    .EXAMPLE
        Get-PrintQueue -ComputerName ps -Name HPCLJ5500
    .LINK
        https://code.google.com/p/mod-posh/wiki/PrintServertManagement#Get-PrintQueue
    #>
    [CmdletBinding()]
    Param
        (
        $ComputerName,
        $Name
        )
    Begin
    {
        $Host.Runspace.ThreadOptions = "ReuseThread"
        if ((Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture -eq '64-bit')
        {
            $SystemPrinting = Get-ChildItem "$($env:systemroot)\assembly\GAC_64\System.Printing"
            $SystemPrintingFile = Get-ChildItem -Name "*system.printing*" -Recurse -Path $SystemPrinting.FullName
            $SystemPrintingFile = "$($SystemPrinting.FullName)\$($SystemPrintingFile)"
            }
        else
        {
            $SystemPrinting = Get-ChildItem "$($env:systemroot)\assembly\GAC_32\System.Printing"
            $SystemPrintingFile = Get-ChildItem -Name "*system.printing*" -Recurse -Path $SystemPrinting.FullName
            $SystemPrintingFile = "$($SystemPrinting.FullName)\$($SystemPrintingFile)"
            }
        }
    Process
    {
        $ErrorActionPreference = "Stop"
        Try
        {
            Add-Type -Path $SystemPrintingFile
            $PrintServer = New-Object System.Printing.PrintServer("\\$($ComputerName)")
            $PrintQueue = $PrintServer.GetPrintQueue($Name)
            }
        Catch
        {
            Write-Error $Error[0].Exception
            Break
            }
        }
    End
    {
        Return $PrintQueue
        }
    }
Function Get-PrintJobs
{
    <#
    .SYNOPSIS
        Return the list of jobs on the current printer
    .DESCRIPTION
        This function returns a list of pending jobs on the specified print server for a given queue
    .PARAMETER ComputerName
        Name of the print sever
    .PARAMETER Name
        Name of the print queue
    .EXAMPLE
        Get-PrintJobs -ComputerName ps -Name HPLJ5000
    .LINK
        https://code.google.com/p/mod-posh/wiki/PrintServerManagement#Get-PrintJobs
    #>
    [CmdletBinding()]
    Param
        (
        $ComputerName,
        $Name
        )
    Begin
    {
        $Host.Runspace.ThreadOptions = "ReuseThread"
        if ((Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture -eq '64-bit')
        {
            $SystemPrinting = Get-ChildItem "$($env:systemroot)\assembly\GAC_64\System.Printing"
            $SystemPrintingFile = Get-ChildItem -Name "*system.printing*" -Recurse -Path $SystemPrinting.FullName
            $SystemPrintingFile = "$($SystemPrinting.FullName)\$($SystemPrintingFile)"
            }
        else
        {
            $SystemPrinting = Get-ChildItem "$($env:systemroot)\assembly\GAC_32\System.Printing"
            $SystemPrintingFile = Get-ChildItem -Name "*system.printing*" -Recurse -Path $SystemPrinting.FullName
            $SystemPrintingFile = "$($SystemPrinting.FullName)\$($SystemPrintingFile)"
            }
        }
    Process
    {
        $ErrorActionPreference = "Stop"
        Try
        {
            Add-Type -Path $SystemPrintingFile
            $PrintServer = New-Object System.Printing.PrintServer("\\$($ComputerName)")
            $PrintQueue = $PrintServer.GetPrintQueue($Name)
            $PrintJobs = $PrintQueue.GetPrintJobInfoCollection()
            }
        Catch
        {
            Write-Error $Error[0].Exception
            Break
            }
        }
    End
    {
        Return $PrintJobs
        }
    }
```

