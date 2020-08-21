Function Get-LHSPrintJob
{
<#
.SYNOPSIS
    Get PrintJobs on local or remote Computer.

.DESCRIPTION
    Get PrintJobs on local or remote Computer using WMI

.PARAMETER ComputerName
    The computer name(s) to retrieve the info from. 
    Default to local Computer

.PARAMETER PrinterName
    An existing Print Queue Name. Wildcard (*) support. 
    Default to '*' (all Print Queues) 

.PARAMETER Credential
    Alternate Credential to connect to the remote Computer

.EXAMPLE
    Get-LHSPrintJob -ComputerName Server1 -PrinterName 'd363*'

    Wildcard support, to list all PrintJobs for all Print Queues with name beginning with 'd363'.

.EXAMPLE
    PS C:\> Get-LHSPrintJob -ComputerName Server1 | where {$_.Status -eq 'Error'}

    To list all Printjobs of all Print Queues with Status:Error from PrintServer Server1

.EXAMPLE
    Get-LHSPrintJob -ComputerName Server1 |
    Where { $_.ConvertToDateTime($_.TimeSubmitted) -lt (Get-Date).AddDays(-5) }

    To list all Printjobs of all Print Queues older than 5 Days from PrintServer Server1

.EXAMPLE
    PS C:\> Get-LHSPrintJob -ComputerName Server1 | where {$_.Status -eq 'Error'} |
    Foreach-Object { $_.Delete() } 

    To Delete Printjobs with status 'Error' of all Print Queues on PrintServer Server1

.INPUTS
    System.String, you can pipe ComputerNames to this Function

.OUTPUTS
    TypeName: System.Management.ManagementObject#root\CIMV2\Win32_PrintJob

.NOTES
    use |select * to see all Properties

    AUTHOR: Pasquale Lantella 
    LASTEDIT: 16.02.2015
    KEYWORDS: PrintJob

.LINK
    Get-WmiObject    

#Requires -Version 2.0
#>
   
[cmdletbinding()]  

[OutputType('System.Management.ManagementObject#root\CIMV2\Win32_PrintJob')]

Param(

    [Parameter(Position=0,Mandatory=$False,ValueFromPipeline=$True,
        HelpMessage='An array of computer names. The default is the local computer.')]
	[alias("CN")]
	[string[]]$ComputerName = $Env:COMPUTERNAME,

    [Parameter(Position=1)]
	[string]$PrinterName = '*',

    [parameter(Position=2)]
    [Alias('RunAs')]
    [System.Management.Automation.Credential()]$Credential = [System.Management.Automation.PSCredential]::Empty
   )

BEGIN {

    Set-StrictMode -Version Latest
    ${CmdletName} = $Pscmdlet.MyInvocation.MyCommand.Name

    # create WMI filter
    # we need special handling to filter for Printer Names
    If ($PrinterName -match [Regex]::Escape('*'), "*")
    {
        # replace wildcard as WMI uses '%'
        $PrinterName = "$PrinterName" -replace [Regex]::Escape('*'), '%'
        [String]$WMIFilter = "Name like '" + "$PrinterName" + "'"                    
        Write-Debug "`$WMIFilter contains: $WMIFilter"
    }
    Else
    {
        #we don´t have wildcards and want to filter for the exact name
        [String]$WMIFilter = "Name like '" + "$PrinterName" + "'"                    
        Write-Debug "`$WMIFilter contains: $WMIFilter"
    } 


} # end BEGIN

PROCESS {
    
    ForEach ($Computer in $ComputerName) 
    {
        IF (Test-Connection -ComputerName $Computer -Count 2 -Quiet) 
        {
            $WMIParam = @{
                ComputerName = $Computer;
                Class = 'Win32_Printjob';
                Namespace = 'root\CIMV2';
                ErrorAction = 'Stop';
            }

            If ($PSBoundParameters['Credential'])
            {
                $WMIParam.Credential = $Credential;
            }
 
            Try
            {
                Get-WmiObject @WMIParam -Filter $WMIFilter | 
                Add-Member -MemberType NoteProperty -Name ComputerName -Value $Computer -PassThru
            }
            Catch
            {
                Write-Error $_
            }             
                
        } 
        Else 
        {
            Write-Warning "\\$Computer DO NOT reply to ping" 
        } # end IF (Test-Connection -ComputerName $Computer -count 2 -quiet)
      
	   
    } # end ForEach ($Computer in $ComputerName)

} # end PROCESS

END { Write-Verbose "Function ${CmdletName} finished." }

} # end Function Get-LHSPrintJob          
             