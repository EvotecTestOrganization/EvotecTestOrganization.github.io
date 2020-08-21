<#
  ****************************************************************
  * DO NOT USE IN A PRODUCTION ENVIRONMENT UNTIL YOU HAVE TESTED *
  * THOROUGHLY IN A LAB ENVIRONMENT. USE AT YOUR OWN RISK.  IF   *
  * YOU DO NOT UNDERSTAND WHAT THIS SCRIPT DOES OR HOW IT WORKS, *
  * DO NOT USE IT OUTSIDE OF A SECURE, TEST SETTING.             *
  ****************************************************************
#> 
Function Set-LHSPrinterDriver
{
<#
.SYNOPSIS
    Set/Replace a Printer Driver on local or remote Computer.

.DESCRIPTION
    [Optional] Set/Replace a Printer Driver on local or remote Computer.
    The Printer Drivers must be installed, This Function is not going to install Printer Drivers.
    Printers that do not replay to ping will be skipped.

.PARAMETER ComputerName
    The computer name(s) to where you want to set\change Print Drivers. 
    Default to local Computer

.PARAMETER PrinterName
    [Optional] The Printer Name you want to set\change the Print Driver.
    You can use the Asterix '*' as wildcard to set\change Printer Drivers on a set of Printers.
    Default is '*' - All Printers. 

.PARAMETER OldDriverName
    [Optional] Used to filter Printer with this Print Driver Name.
    Use this Parameter if you want to replace Print Drivers on all Printers that uses 
    the given Driver Name.

.PARAMETER NewDriverName
    The Print Driver Name of an existing(installed) Driver that you want to set for the given Printers.

.PARAMETER Force
    [Optional] Used for the ShouldProcess, Shouldcontinue. 
    To override these confirmations use	-Confirm:$false or the -Force parameter.
    
    More Info:
    The variable: $ConfirmPreference default is 'High' and you should not change that.
    If the User selected -Confirm, has the effect that $Global:ConfirmPreference is set to Low.
        
    You can declare the impact of the commands on the system: "HIGH", "MEDIUM", "LOW".
    You can then set ConfirmImpact to be the level that you want Automatic confirmation turned on. 
    
    When the ConfirmImpact is less than the $ConfirmPreference than only when you pass the 
    Switch -Confirm the user will be prompted to confirm. If you want allways the user has to confirm
    even whith the -Force Parameter used, then set the ConfirmImpact  = 'High'


.EXAMPLE
    Set-LHSPrinterDriver -ComputerName Server1 -OldDriverName 'RICOH Aficio MP C2550 PCL 5c' -NewDriverName 'RICOH Aficio MP C3300 PCL 6' -WhatIf
    
    Connects to Server1 and replaces on all Printers which have Printer Driver 'RICOH Aficio MP C2550 PCL 5c' to
    'RICOH Aficio MP C3300 PCL 6'. The -Whatif Parameter will not make any changes but will show what will be done.

.EXAMPLE
    Set-LHSPrinterDriver -ComputerName Server1 -PrinterName "Test*" -NewDriverName 'RICOH Aficio MP C3300 PCL 6' -Force

    Connects to Server1 and will set on all Printers with Name beginning with Test (wildcard support) to the new Print Driver.
    The -Force Switch is to bypass the confirmation.

.EXAMPLE
    # check the number of Print Queues with Driver = 'HP Universal Printing PCL 6'
    $p = Get-Wmiobject -Class win32_printer -ComputerName server1 -Filter "DriverName like 'HP Universal Printing PCL 6'"
    $p.count

    # create a filename after ISO 8601 standard sortable date time-stamp
    $dt = (Get-Date).ToString("s").Replace(":","-")           
    Set-LHSPrinterDriver -ComputerName server1 -OldDriverName 'HP Universal Printing PCL 6' -NewDriverName 'HP Universal Printing PCL 6 (v5.6.5)' *>&1 | 
    Out-File -FilePath "C:\Temp\log\$dt.txt"          

    will replace Printer Driver on Print queues of server1 that have the current Print Driver 'HP Universal Printing PCL 6'
    and replaces with 'HP Universal Printing PCL 6 (v5.6.5)'.
    '*>&1' is to redirect all outputs(verbose,warning,error,debug) to the standard output (requires PS V3.0 or higher).
    We pipe the output then to a file.
    
.INPUTS
    System.String, you can pipe ComputerNames to this Function

.OUTPUTS
    None

.NOTES
    The .put() command do not work with Get-CimInstance 

    AUTHOR: Pasquale Lantella 
    LASTEDIT: 
    KEYWORDS: Set Printer Driver

.LINK
    Get-WmiObject

#Requires -Version 2.0
#>
   
[cmdletbinding(  
    DefaultParameterSetName = 'Default',  
    ConfirmImpact = 'High',
    SupportsShouldProcess = $True
)]  

[OutputType('None')] 

Param(

    [Parameter(ParameterSetName='Default', Position=0,Mandatory=$False,ValueFromPipeline=$True,
        HelpMessage='An array of computer names. The default is the local computer.')]
    [Parameter(ParameterSetName='Replace',Position=0, Mandatory=$False,ValueFromPipeline=$True)]
	[alias("CN")]
	[string[]]$ComputerName = $Env:COMPUTERNAME,

    [Parameter(ParameterSetName='Default', Position=1,Mandatory=$False,
        HelpMessage='A Printer name. The default is all Printers.')]
    [Parameter(ParameterSetName='Replace',Position=1, Mandatory=$False)]
	[string]$PrinterName = "*",

    [Parameter(ParameterSetName='Replace', Position=2,Mandatory=$False,
        HelpMessage='The current Printer Driver Name of a Print Queue.')]
	[string]$OldDriverName,

    [Parameter(ParameterSetName='Default',Position=2,Mandatory=$True,
        HelpMessage='The new Printer Driver Name.')]
    [Parameter(ParameterSetName='Replace',Position=3, Mandatory=$True)]
	[string]$NewDriverName,

    [Parameter(ParameterSetName='Default', Position=3)]
    [Parameter(ParameterSetName='Replace',Position=4)]
    [Switch]$Force
    
   )

BEGIN {

    Set-StrictMode -Version Latest
    ${CmdletName} = $Pscmdlet.MyInvocation.MyCommand.Name

#region ShouldProcess 
    #----------------------------------------------------------------------------
    Write-Verbose "Section for Supporting ShouldProcess (-Confirm)"
    If ($ConfirmPreference -eq 'Low') {
        <# 
            User:
            * selected -Confirm 
            * has $Global:ConfirmPreference set to Low.
        #>

        $YesToAll = $false

    } Else {
        # No -Confirm, so we won't prompt the user...
        $YesToAll = $true
    }
    # NoToAll is always $false - we want to give it a try...
    $NoToAll = $false
    Write-Verbose "End Section for supporting ShouldProcess"
    #----------------------------------------------------------------------------	
#endregion ShouldProcess 

#region WMIfilter
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
#endregion WMIfilter


   
} # end BEGIN

PROCESS {
    
    ForEach ($Computer in $ComputerName) 
    {
        IF (Test-Connection -ComputerName $Computer -count 2 -quiet) 
        { 
            
            Write-Verbose "Get Printer(s) from \\$Computer"
            $Printers = Get-WmiObject -Class win32_printer -ComputerName $Computer -Filter $WMIFilter 

            Foreach ($Printer in $Printers)
            {
                Write-Verbose "Print Driver:$($Printer.DriverName), PrinterName:$($Printer.Name) from \\$Computer"
                
                switch ($PsCmdlet.ParameterSetName) 
                {
                    'Default' {
                                # Set Printer Driver on Printers defined by -PrinterName (Default is *, all Printers)
                                $query = "Setting Print Driver [$NewDriverName] on Printer:\\$Computer\$($Printer.Name) ?"
                                $caption = 'Attention!'
                                If ($pscmdlet.ShouldProcess(
                                    "Setting Print Driver [$NewDriverName] on Printer:\\$Computer\$($Printer.Name)",
                                    "$query",
                                    "$caption"))
                                {
                                    If ($Force -or $pscmdlet.ShouldContinue(
                                        [string] $query,
                                        [string] $caption,
                                        [ref][bool] $YesToAll,
                                        [ref][bool] $NoToAll  ))
                                    {
                                        # change Print Driver only if Printer is online
                                        IF (Test-Connection -ComputerName $($Printer.Name) -count 2 -quiet)
                                        {
                                            $Printer.DriverName = $NewDriverName
                                            $Printer.put()    
                                        }
                                        Else 
                                        {
                                            Write-Warning "\\$($Printer.Name) DO NOT reply to ping" 
                                        } # end IF (Test-Connection -ComputerName $($Printer.Name) -count 2 -quiet) 
                                    }
                                } #end If ($pscmdlet.ShouldProcess)

 
                              }
                    'Replace' {
                                # Replace Printer Driver only on Printers defined by -PrinterName (Default is *, all Printers)
                                # and if match -OldDriverName
                                IF ($Printer.DriverName -eq $OldDriverName)
                                {
                                    $query = "Setting Print Driver [$NewDriverName] on Printer:\\$Computer\$($Printer.Name) ?"
                                    $caption = 'Attention!'
                                    If ($pscmdlet.ShouldProcess(
                                        "Setting Print Driver [$NewDriverName] on Printer:\\$Computer\$($Printer.Name)",
                                        "$query",
                                        "$caption"))
                                    {
                                        If ($Force -or $pscmdlet.ShouldContinue(
                                            [string] $query,
                                            [string] $caption,
                                            [ref][bool] $YesToAll,
                                            [ref][bool] $NoToAll  ))
                                        {
                                            # change Print Driver only if Printer is online
                                            IF (Test-Connection -ComputerName $($Printer.Name) -count 2 -quiet)
                                            {
                                                $Printer.DriverName = $NewDriverName
                                                $Printer.put()    
                                            }
                                            Else 
                                            {
                                                Write-Warning "\\$($Printer.Name) DO NOT reply to ping" 
                                            } # end IF (Test-Connection -ComputerName $($Printer.Name) -count 2 -quiet) 
                                        }
                                    } #end If ($pscmdlet.ShouldProcess)                                 

                                } # end IF ($Printer.DriverName -eq $OldDriverName)                                 
                              }  
                } # end Switch

            } # end Foreach ($Printer in $Printers)

        } 
        Else 
        {
            Write-Warning "\\$Computer DO NOT reply to ping" 
        } # end IF (Test-Connection -ComputerName $Computer -count 2 -quiet)
      
	   
    } # end ForEach ($Computer in $ComputerName)

} # end PROCESS

END { Write-Verbose "Function ${CmdletName} finished." }

} # end Function Set-LHSPrinterDriver

