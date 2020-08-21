<#
	Author  : Nick Boardman
	E-Mail  : nboardman@hotmail.com
	Date	: September 24, 2014
	File	: Get-Printers.ps1
	Purpose : Retrieve a list of all printers throughout the HRSD network.
	Version : 1.0
	Notes   : 
#>

#Start Timer
$elapsedTime = [system.diagnostics.stopwatch]::StartNew()
#For Error-handling
$ErrorActionPreference = "SilentlyContinue"
#To eliminate truncation of returned data -1 = unlimited
$FormatEnumerationLimit =-1

$Results = @()

$Servers = "Server1","Server2","Server3"

 foreach ($Server in $Servers) {
 	Write-Host == "Querying $Server..." ==
		$Results += gwmi win32_printer -computername $Server | Select-Object SystemName,Name,Location,Portname,DriverName,@{N='Capabilities';E={$_.CapabilityDescriptions}},Comment 
	}
	
$Results | Sort-Object SystemName | Export-Csv -Path C:\Printers.csv -NoTypeInformation

ii C:\Printers.csv

Write-Host "The script is done processing" -Fore Green
Write-Host ("Elapsed Time : {0}" -f $($ElapsedTime.Elapsed.ToString())) -Fore Green