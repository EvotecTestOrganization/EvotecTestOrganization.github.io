<#

Created:  January 31, 2014

Version:  1.0

Description:  This script modifies the default paper tray on a printer.

Requirements:  This script requires the PrintManagement PowerShell module that comes
included with Windows Server 2012 and Windows 8.X.

Here are the steps to run this script.

1.  Open the script in PowerShell ISE
2.  Modify the $strPrinterName variable to the be name of the printer.
3.  Modify the $strTray variable to the desired default paper size.  The acceptable 
    values are AutoSelect, ManualFeed, Tray1, Tray2, Tray3, and Tray4
4.  Execute the script.

#>

# Specify the name of the printer.
$strPrinterName = "PrinterName"

# Specify the tray to set as the default.  The acceptable values are AutoSelect, ManualFeed, 
# Tray1, Tray2, Tray3, and Tray4
$strTray = "Tray1"

# Get the printer's current PrintTicketXml configuration.
$objGetPrintConfiguration = Get-PrintConfiguration -printername $strPrinterName
$xmlPrintTicketXML = [xml]$objGetPrintConfiguration.PrintTicketXML

# Determine where the JobInputBin element is located in the PrintTicketXml.
$strFindJobInputBin = $xmlPrintTicketXML.PrintTicket.Feature 

$strFindJobInputBin = for($i=0;$i-le $strFindJobInputBin.length-1;$i++) {
        if ($strFindJobInputBin.name[$i] -eq 'psk:JobInputBin') {$i; break}
    }
$strCount = $strFindJobInputBin

# Use the location of the JobInputBin in the PrintTicketXml to determine the corresponding value.
$JobInputBinCurrentValue = $xmlPrintTicketXML.DocumentElement.Feature.Option.Name.Get($strCount)
# $JobInputBinCurrentValue # This can be enabled and used to print out the updated PrintTicketXml 
# configuration before updating the printer with it.

# If the $strTray equals "AutoSelect", then perform the following action.
If ($strTray -eq "AutoSelect")
    {
        $strPSK = 'psk:'
        $strPSKandTray = $strPSK + $strTray
        # $strPSKandTray # This can be enabled and used to print out the updated PrintTicketXml 
        # configuration before updating the printer with it.

        # Then, replace the current JobInputBin value with the user defined JobInputBin value.
        $strGetPrintConfiguration = Get-PrintConfiguration -printername $strPrinterName
        $strPrintTicketXML = $strGetPrintConfiguration.PrintTicketXML
        $strReplaceJobInputBin = $strPrintTicketXML -replace "$JobInputBinCurrentValue","$strPSKandTray" 
        # $strReplaceJobInputBin # This can be enabled and used to print out the updated PrintTicketXml 
        # configuration before updating the printer with it.

        # Next, update the printer's PrintTicketXml configuration with the user defined JobInputBin value.
        Set-PrintConfiguration -printername $strPrinterName -PrintTicketXml $strReplaceJobInputBin

        Write-Host "The JobInputBin was changed as per the following.
        From:  $JobInputBinCurrentValue
        To:  $strPSKandTray"

    }
Else
    {
        $strNS0000 = 'ns0000:'
        $strNS0000andTray = $strNS0000 + $strTray

        # If $strTray equals another of the acceptable values, replace the current JobInputBin value 
        # with the user defined JobInputBin value.
        $strGetPrintConfiguration = Get-PrintConfiguration -printername $strPrinterName
        $strPrintTicketXML = $strGetPrintConfiguration.PrintTicketXML
        $strReplaceJobInputBin = $strPrintTicketXML -replace "$JobInputBinCurrentValue","$strNS0000andTray" 
        # $strReplaceJobInputBin # This can be enabled and used to print out the updated PrintTicketXml 
        # configuration before updating the printer with it.

        # Next, update the printer's PrintTicketXml configuration with the user defined JobInputBin value.
        Set-PrintConfiguration -printername $strPrinterName -PrintTicketXml $strReplaceJobInputBin

        Write-Host "The JobInputBin was changed as per the following.
        From:  $JobInputBinCurrentValue
        To:  $strNS0000andTray"
    }
