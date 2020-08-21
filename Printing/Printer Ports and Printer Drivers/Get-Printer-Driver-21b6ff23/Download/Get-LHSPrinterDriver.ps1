Function Get-LHSPrinterDriver
{
<#
.SYNOPSIS
    Get Printer Driver Information from local or remote Computers.

.DESCRIPTION
    Get Information about Printer Drivers (Driver Version,language, plattform and dependent files).

.PARAMETER ComputerName
    The computer name(s) to retrieve the info from.
    Default to local Computer. 

.PARAMETER DriverName
    The driver name, support for wildcard '*'. 

.EXAMPLE
    PS C:\> Get-LHSPrinterDriver | Select *

    Outputs all Printer driver infos from local Computer
    Use Select * to see all properties.

.EXAMPLE
    PS C:\> Get-LHSPrinterDriver -ComputerName Server1 -DriverName "HP Universal Printing*"
    ComputerName      : Server1
    DriverName        : HP Universal Printing PS (v5.5.0)
    DriverVersion     : 6.1.7600.16385
    SupportedPlatform : Windows x64
    Language          : Deutsch (Deutschland)

    ComputerName      : Server1
    DriverName        : HP Universal Printing PS (v5.4)
    DriverVersion     : 6.1.7600.16385
    SupportedPlatform : Windows x64
    Language          : Deutsch (Deutschland)
    ..

.EXAMPLE

    PS C:\> $p = Get-LHSPrinterDriver -ComputerName Server1 -DriverName "HP Universal Printing PCL 6 (v5.4)"
    PS C:\> $p.DependentFiles

    PS C:\> $p.DependentFiles
    C:\Windows\system32\spool\DRIVERS\x64\3\hpcui118.dll
    C:\Windows\system32\spool\DRIVERS\x64\3\hpcpe118.dll
    C:\Windows\system32\spool\DRIVERS\x64\3\hpcdmc64.dll
    C:\Windows\system32\spool\DRIVERS\x64\3\hpbcfgre.dll
    C:\Windows\system32\spool\DRIVERS\x64\3\hpcpu118.cfg
    C:\Windows\system32\spool\DRIVERS\x64\3\hpc6r118.dll
    C:\Windows\system32\spool\DRIVERS\x64\3\hpcsm118.gpd
    ..


.INPUTS
    System.String, you can pipe ComputerNames to this Function

.OUTPUTS
    Custom PSObjects containing the following properties:
    
    ComputerName      : As String , default output
    DriverName        : As String , default output
    DriverVersion     : As String , default output
    SupportedPlatform : As String , default output
    Language          : As String , default output
    ConfigFile        : As String
    DataFile          : As String
    DependentFiles    : As String array
    SupportedPlatform : As String    

.NOTES
    
    AUTHOR: Pasquale Lantella 
    LASTEDIT: 
    KEYWORDS: 

.LINK
    win32_printerdriver 

#Requires -Version 2.0
#>
   
[cmdletbinding()]  

[OutputType('PSObject')] 

Param(

    [Parameter(Position=0,ValueFromPipeline=$True,
        HelpMessage='An array of computer names. The default is the local computer.')]
	[alias("CN")]
	[string[]]$ComputerName = $Env:COMPUTERNAME,
    

    [Parameter(Position=1)]
	[string]$DriverName = "*"

   )

BEGIN {

    Set-StrictMode -Version Latest

    ${CmdletName} = $Pscmdlet.MyInvocation.MyCommand.Name

    # create WMI filter
    # we need special handling to filter for driver names
    If ($DriverName -match [Regex]::Escape('*'), "*")
    {
        # replace wildcard as WMI uses '%'
        $DriverName = "$DriverName" -replace [Regex]::Escape('*'), '%'
        [String]$Filter = "Name like '" + "$DriverName" + "'"                    
        Write-Debug "`$Filter contains: $Filter"
    }
    Else
    {
        #we don´t have wildcards and want to filter for the exact name
        # example of how driver names looks like: "SHARP UD PCL6,3,Windows x64"
        [String]$Filter = "Name like '" + "$DriverName" + ",%'"                    
        Write-Debug "`$Filter contains: $Filter"
    }

} # end BEGIN

PROCESS {
   
    ForEach ($Computer in $computerName) 
    {
        IF (Test-Connection -ComputerName $Computer -count 2 -quiet) 
        { 
            $drivers = Get-WmiObject -Class win32_printerdriver -ComputerName $Computer -Filter $Filter
            Foreach ($driver in $drivers)
            {
                $DriverName = ($driver.Name.split(","))[0]

                $SupportedPlatform = $driver.SupportedPlatform

                # create PSObject the V2 way
                $outputObject = New-Object PSObject -Property @{

                       ComputerName = $Computer 
                       DriverName = $DriverName
                       DriverPath = $driver.DriverPath
                       DriverVersion = (Get-ItemProperty -path ("\\$Computer\" + "$($driver.DriverPath)" -replace [Regex]::Escape('c:'), 'C$')).VersionInfo.ProductVersion
                       Language = (Get-ItemProperty ("\\$Computer\" + "$($driver.DriverPath)" -replace [Regex]::Escape('c:'), 'C$')).VersionInfo.Language
                       ConfigFile = $driver.ConfigFile;
                       DataFile = $driver.DataFile;
                       DependentFiles = $driver.DependentFiles;
                       SupportedPlatform = $SupportedPlatform

                } | Select ComputerName, DriverName, SupportedPlatform, DriverPath,DriverVersion,Language,ConfigFile, DataFile, DependentFiles

                # define a custom TypeName
                $outputObject.PSTypeNames.Clear()
                $outputObject.PSTypeNames.Add('LHS.PrinterDriverInfo')

                # optional, set default visible properties on return object (applies to PS 3.0 only, no effect in PS 2.0):
                [String[]]$properties = 'ComputerName','DriverName','DriverVersion','SupportedPlatform','Language'
                [System.Management.Automation.PSMemberInfo[]]$PSStandardMembers = New-Object System.Management.Automation.PSPropertySet DefaultDisplayPropertySet,$properties

                $outputObject | Add-Member -MemberType MemberSet -Name PSStandardMembers -Value $PSStandardMembers
                $outputObject    

            } # end Foreach ($driver in $drivers)
        } 
        Else 
        {
            Write-Warning "\\$computer DO NOT reply to ping" 
        } # end IF (Test-Connection -ComputerName $Computer -count 2 -quiet)
      
	   
    } # end ForEach ($Computer in $computerName)

} # end PROCESS

END { Write-Verbose "Function ${CmdletName} finished." }

} # end Function Get-LHSPrinterDriver            


