<#
Created:  February 2, 2018

Version:  1.2

Summary:  This script will check to see if the Everyone group has rights to the 
defined printer, if it does, then it will remove the access.

The script will first report the current rights to the printer in the PowerShell
console.  If the Everyone group has permissions, these permissions will be removed,
and then the updated printer permissions will be output to the PowerShell console.

Here are the steps to run this script.

1.  Launch PowerShell ISE with an account that has access rights to modify the printer 
permissions (i.e. right-click on PowerShell ISE, and select to "Run As" this account).

2.  Modify the $PrinterName  variable to be the name of the printer that will have
the Everyone group removed from accessing.

3.  Execute the script.

Requirements: Run this script on the server that hosts the printer.

The account that is used to run this script, needs to have access rights to 
remove printer permissions.  As a result, we need to launch PowerShell ISE with an 
account that has these rights.  To do this, right-click on PowerShell ISE, and select to 
"Run As" this account.
#>

# Define this variable with the name of the printer.
$PrinterName = "NameOfPrinter"


# Get the properties of the printer.
$colPrinters = Get-Printer -Full -Name $PrinterName
Foreach ($Printer in $colPrinters)
{

  # Write to the PowerShell console the name of the printer and the corresponding permission list (the SDDL).
  $PrinterName = $Printer.Name
  Write-Host "Printer:  $PrinterName"
  $PrinterSddl = $Printer.permissionsddl
  $ConvertSddlString = ConvertFrom-SddlString -Sddl $PrinterSddl
  $ConvertSddlString.DiscretionaryAcl

  # Modify the SDDL of the printer.
  $PrinterSddlEdit = $PrinterSddl -split "\(" | where {$_ -like "*;WD)"} | select -First 10

  # Remove each instance of the Everyone group from the SDDL.
  Foreach ($Sddl in $PrinterSddlEdit)
  {
    $SddlEdit = "($Sddl"
    $PrinterSddl = $PrinterSddl -Replace "\($SddlEdit\)",""
  }

  # Apply the updated SDDL to the printer.
  Set-Printer -Name $PrinterName -PermissionSDDL $PrinterSddl

  # Re-check the permissions on the printer.
  $colPrinters = Get-Printer -Full -Name $PrinterName
  Foreach ($Printer in $colPrinters)
  {
    # Write to the PowerShell console the name of the printer and the corresponding SDDL.
    $PrinterName = $Printer.Name
    Write-Host "`nPrinter:  $PrinterName"
    $PrinterSddl = $Printer.permissionsddl
    $ConvertSddlString = ConvertFrom-SddlString -Sddl $PrinterSddl
    $ConvertSddlString.DiscretionaryAcl
  }
}