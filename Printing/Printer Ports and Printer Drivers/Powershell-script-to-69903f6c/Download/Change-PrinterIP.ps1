<# 
 .Synopsis
  Script to change printer IP address

 .Description
  This script changes printer IP address
  It leaves a log file in the current folder that lists script progress

 .Parameter OldIP
  Example: 192.168.0.99 
  
 .Parameter NewIP
  Example: 192.168.0.95 
  
 .Example
   .\Change-PrinterIP.ps1 192.168.0.99 192.168.0.95
   This example changes the printer attached to the print port with IP 192.168.0.99
   It creates a new printer port with same settings as the old 192.168.0.99 printer port,
   assigns the printer to the new port, and deletes the old printer port

 .Link
  https://superwidgets.wordpress.com/category/powershell/

 .Notes
  v1.0 - 07/27/2014 

#>

#==============================================================================
# Script Name:    	Change-PrinterIP.ps1
# DATE:           	07/27/2014
# Version:        	1.0
# COMMENT:			Script to change printer IP address
#==============================================================================
#    
[CmdletBinding()]
param(
    [Parameter (Mandatory=$true,Position=0,HelpMessage="Printer's old IP: ")][String]$OldIP,
    [Parameter (Mandatory=$true,Position=1,HelpMessage="Printer's new IP: ")][String]$NewIP
)
#
# Log function
function Log {
    [CmdletBinding()]
    param(
        [Parameter (Mandatory=$true,Position=1,HelpMessage="String to be saved to log file and displayed to screen: ")][String]$String,
        [Parameter (Mandatory=$false,Position=2)][String]$Color = "White",
        [Parameter (Mandatory=$false,Position=3)][String]$Logfile = $myinvocation.mycommand.Name.Split(".")[0] + "_" + (Get-Date -format yyyyMMdd_hhmmsstt) + ".txt"
    )
    write-host $String -foregroundcolor $Color  
    ((Get-Date -format "yyyy.MM.dd hh:mm:ss tt") + ": " + $String) | out-file -Filepath $Logfile -append
}
#
$LogFile = (Get-Location).path + "\Change-PrinterIP_" + $env:COMPUTERNAME + (Get-Date -format yyyyMMdd_hhmmsstt) + ".txt"
$Port = Get-PrinterPort -Name "IP_$OldIP"
log "Old printer port:" Cyan $LogFile
log ("    Protocol:           " + $port.Protocol) Cyan $LogFile
log ("    Description:        " + $port.Description) Cyan $LogFile
log ("    Name:               " + $port.Name) Cyan $LogFile
log ("    Port Number:        " + $port.PortNumber) Cyan $LogFile
log ("    PrinterHostAddress: " + $port.PrinterHostAddress) Cyan $LogFile
log ("Printer was attached to printer port: " + (Get-Printer | Where-Object { $_.PortName -eq "IP_$OldIP" }).PortName) Cyan $LogFile
#
# Create new printer port
Add-PrinterPort -Name "IP_$NewIP" -LprHostAddress $NewIP -LprQueueName (Get-PrinterPort -Name IP_$OldIP).LprQueueName
#
# Assign new printer port to the printer
Get-Printer | Where-Object { $_.PortName -eq "IP_$OldIP" } | Set-Printer -PortName "IP_$NewIP" 
#
# Delete old printer port
Remove-PrinterPort -Name "IP_$OldIP"
#
$Port = Get-PrinterPort -Name "IP_$NewIP"
log "New printer port:" Green $LogFile
log ("    Protocol:           " + $port.Protocol) Green $LogFile
log ("    Description:        " + $port.Description) Green $LogFile
log ("    Name:               " + $port.Name) Green $LogFile
log ("    Port Number:        " + $port.PortNumber) Green $LogFile
log ("    PrinterHostAddress: " + $port.PrinterHostAddress) Green $LogFile
log ("Printer is now attached to printer port: " + (Get-Printer | Where-Object { $_.PortName -eq "IP_$NewIP" }).PortName) Green $LogFile