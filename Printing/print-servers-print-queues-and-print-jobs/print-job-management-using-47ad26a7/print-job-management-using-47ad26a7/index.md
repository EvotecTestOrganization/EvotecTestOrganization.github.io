# Print Job Management using Powershell

## Original Links

- [x] Original Technet URL [Print Job Management using Powershell](https://gallery.technet.microsoft.com/Print-Job-Management-using-47ad26a7)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Print-Job-Management-using-47ad26a7/description)
- [x] Download: [Download Link](Download\Get-LHSPrintJob.ps1)

## Output from Technet Gallery

Print Job Management using Powershell

Both Windows 8.1 and Server 2012 R2 come with a module called “PrintManagement”. It includes all cmdlets needed to manage local and remote printers.

for Windows 7 and Server 2008R2 we have to use WMI Powershell scripting. This was the reason to have this advanced powwrshell function to manage Print Jobs.

Using this function you will be able to to the following:

To Delete Printjobs with status 'Error' of all Print Queues on PrintServer: Server1,Server2,Server3

PS C:\&gt; Get-LHSPrintJob -ComputerName Server1,Server,Server3 | where {$\_.Status -eq 'Error'} | Foreach-Object { $\_.Delete() }

To Delete all Printjobs of all Print Queues older than 5 Days from PrintServer Server1

Get-LHSPrintJob -ComputerName Server1 |

    Where { $\_.ConvertToDateTime($\_.TimeSubmitted) -lt (Get-Date).AddDays(-5) } | Foreach-Object { $\_.Delete() }

We can also filter Printer Names using the Parameter -PrinterName using wildcard (\*)

Get-LHSPrintJob -ComputerName Server1 -PrinterName 'd363\*'

```
Function Get-LHSPrintJob
{
<#
.SYNOPSIS
    Get PrintJobs on local or remote Computer.
.DESCRIPTION
    Get PrintJobs on local or remote Computer using WMI
.PARAMETER ComputerName
    The computer name(s) to retrieve the info from.
    Default to local Computer
.PARAMETER PrinterName
    An existing Print Queue Name. Wildcard (*) support.
    Default to '*' (all Print Queues)
.PARAMETER Credential
    Alternate Credential to connect to the remote Computer
.EXAMPLE
    Get-LHSPrintJob -ComputerName Server1 -PrinterName 'd363*'
    Wildcard support, to list all PrintJobs for all Print Queues with name beginning with 'd363'.
.EXAMPLE
    PS C:\> Get-LHSPrintJob -ComputerName Server1 | where {$_.Status -eq 'Error'}
    To list all Printjobs of all Print Queues with Status:Error from PrintServer Server1
.EXAMPLE
    Get-LHSPrintJob -ComputerName Server1 |
    Where { $_.ConvertToDateTime($_.TimeSubmitted) -lt (Get-Date).AddDays(-5) }
    To list all Printjobs of all Print Queues older than 5 Days from PrintServer Server1
.EXAMPLE
    PS C:\> Get-LHSPrintJob -ComputerName Server1 | where {$_.Status -eq 'Error'} |
    Foreach-Object { $_.Delete() }
    To Delete Printjobs with status 'Error' of all Print Queues on PrintServer Server1
.INPUTS
    System.String, you can pipe ComputerNames to this Function
.OUTPUTS
    TypeName: System.Management.ManagementObject#root\CIMV2\Win32_PrintJob
.NOTES
    use |select * to see all Properties
    AUTHOR: Pasquale Lantella
    LASTEDIT: 16.02.2015
    KEYWORDS: PrintJob
.LINK
    Get-WmiObject
#Requires -Version 2.0
#>
[cmdletbinding()]
[OutputType('System.Management.ManagementObject#root\CIMV2\Win32_PrintJob')]
Param(
    [Parameter(Position=0,Mandatory=$False,ValueFromPipeline=$True,
        HelpMessage='An array of computer names. The default is the local computer.')]
    [alias("CN")]
    [string[]]$ComputerName = $Env:COMPUTERNAME,
    [Parameter(Position=1)]
    [string]$PrinterName = '*',
    [parameter(Position=2)]
    [Alias('RunAs')]
    [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty
   )
BEGIN {
    Set-StrictMode -Version Latest
    ${CmdletName} = $Pscmdlet.MyInvocation.MyCommand.Name
    # create WMI filter
    # we need special handling to filter for Printer Names
    If ($PrinterName -match [Regex]::Escape('*'), "*")
    {
        # replace wildcard as WMI uses '%'
        $PrinterName = "$PrinterName" -replace [Regex]::Escape('*'), '%'
        [String]$WMIFilter = "Name like '" + "$PrinterName" + "'"
        Write-Debug "`$WMIFilter contains: $WMIFilter"
    }
    Else
    {
        #we don´t have wildcards and want to filter for the exact name
        [String]$WMIFilter = "Name like '" + "$PrinterName" + "'"
        Write-Debug "`$WMIFilter contains: $WMIFilter"
    }
} # end BEGIN
PROCESS {
    ForEach ($Computer in $ComputerName)
    {
        IF (Test-Connection -ComputerName $Computer -Count 2 -Quiet)
        {
            $WMIParam = @{
                ComputerName = $Computer;
                Class = 'Win32_Printjob';
                Namespace = 'root\CIMV2';
                ErrorAction = 'Stop';
            }
            If ($PSBoundParameters['Credential'])
            {
                $WMIParam.Credential = $Credential;
            }
            Try
            {
                Get-WmiObject @WMIParam -Filter $WMIFilter |
                Add-Member -MemberType NoteProperty -Name ComputerName -Value $Computer -PassThru
            }
            Catch
            {
                Write-Error $_
            }
        }
        Else
        {
            Write-Warning "\\$Computer DO NOT reply to ping"
        } # end IF (Test-Connection -ComputerName $Computer -count 2 -quiet)
    } # end ForEach ($Computer in $ComputerName)
} # end PROCESS
END { Write-Verbose "Function ${CmdletName} finished." }
} # end Function Get-LHSPrintJob
```

