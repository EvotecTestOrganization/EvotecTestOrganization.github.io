#Windows PowerShell Code###########################################################################
#
# AUTHOR: John Grenfell
#
###################################################################################################

<#
    .SYNOPSIS
        Copy the ACL from a source printer to a destination printer

    .DESCRIPTION
        Using the win32_printer wmi object to get both source and destination printer
        Creating a Win32_SecurityDescriptor Instance and then applying it using the 
        .SetSecurityDescriptor method
       
    .PARAMETER p1
        -s The Name of the source printer
        -d The Name of the destination printer

    .EXAMPLE

        PS C:\> Copy-ACLToPrinter.ps1 -s SourcePrinter -d DestinationPrinter
        
    .EXAMPLE

        PS C:\> Copy-ACLToPrinter.ps1 -s TR-Room1-printer1 -d TR-Room1-printer2
        This example should copy the permissions from printer "TR-Room1-printer1" to printer "TR-Room1-printer2"

    .NOTES
        John Grenfell
        Using WMI Object  win32_printer and Win32_SecurityDescriptor .. not a great deal of error trapping.
        I've used this script to set permissions after a PaperCut installation hightlighted the need to adjust
        permissions across 400 printers!
        A return value of 0 is good ;o)
#>

param( [string]$S, [string]$D)

#Get the source printer object
$SFilter = "name='" + $S + "'"
Write-Host "Getting source WMI printerobject using filter : $($SFilter)"
$SPrinter = gwmi win32_printer -filter $SFilter


#Create the security Descriptor
$ace = $SPrinter.GetSecurityDescriptor().Descriptor
If ($ace)
{
    #Add items to the security Descriptor from the source printer
    $SD=([WMIClass] "Win32_SecurityDescriptor").CreateInstance() 
    $SD.ControlFlags = $ace.ControlFlags
    $SD.DACL =$ace.DACL
    $SD.Group =$ace.Group
    $SD.Owner =$ace.Owner
    
    
    #Get the destination printer object
    $DFilter = "name='" + $D + "'"
    Write-Host "Getting destination WMI printerobject using filter : $($DFilter)"
    $DPrinter = gwmi win32_printer -filter $DFilter
    
    #Elevate Privileges (not sure if this is still needed as I still require the code to run as administrator to get the ace ??)
    $DPrinter.psbase.Scope.Options.EnablePrivileges = $true
    
    #Write new SecurityDescriptor to Printer 
    $DPrinter.SetSecurityDescriptor($SD)
  
}
Else
{
    Write-Host "Error reading the security description - check the source printer name is correct and you're running as administrator" 
}
