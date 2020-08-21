################################################################################################################################################
# NAME:		PowerShell Script for Large Scale Printer Migration with New Printserver and New Share name
# WRITTEN BY:	Imran Pathan, Toronto	
# GOAL:		This script is for medium to large scale printer migration with a different server and print queue name
# ENVIRONMENT:	1. Existing Printer names has no standards
#				2. All existing print servers are Windows server 2003 32-bit OS
#				3. Each Print queue has individual model specific print drivers with 32-bit and 64-bit drivers loaded - we want to use UPD and only 3 drivers to manage
#				4. Driver upgrades often caused many Service Desk call due to either new look n feel or missing functionlaity etc
#				5. 95% of the Client OS now are Windows 7 and 5% are either Windows XP or Windows 8
# PROJECT PLAN:	Although project has various stages, apart from this script i have mentioned a quick snopsis as to what is requried in order to
#				make use of this script
#				1. In our environment we have to Migrate all 10 print servers (print queue) to new server ~400 print queues 
#				> http://technet.microsoft.com/en-us/library/dd379488(WS.10).aspx
#				2. Rename all the print Queues and update the drivers with custom Universal print drivers with a setting to color control
#				and default page setup values to duplex for cost saving, most of our fleet is HP and Xerox
#				> HP Universal Print Driver Series for Windows - Resource Kit - http://h20331.www2.hp.com/Hpsub/cache/576122-0-0-225-121.html
#				3. I build a below script to run with GPO which will swap the old printer with new respected printers from a 
#				new server and identify which one was default and make the new respected a degault, 
#				run a test plan in virtual environment and capture the screenshots to communicate with business users well in advance
#				4. Begin the frequent communications at least 2 weeks ahead with users group with what changes to expect and escalate procedure for	
#				issues. Inform and train front line on expected calls and simple solutions. 
#				5. Link the security group filtered GPO for 1 week to target users and measure the scueess rate.
# REFERANCE I USED:
#			1. WMI Code Creator v1.0 - http://www.microsoft.com/en-ca/download/details.aspx?id=8572
#			2. PowerShell Functions and Filters – The basics - http://www.powershellpro.com/powershell-tutorial-introduction/powershell-functions-filters/
# HOW TO USER MY SCRIPT:
#			As a Network Admin or Network Engineering GURU ALL YOU NEED TO DO IN MY SCRIPT is build the case by simply replacing the switches;
#		 	1. i.e. on line 98 "18HookCommRelation-C" is the old printer name.
#			2. "\\SRV-PRNT01\HK-01-C1" is the new printer that you want to replace the old printer with.
#			3. Update and add as many printers you have by copying the syntex and do the correct mapping once, test it in a lab first.
#			4. Once ready simply link the script to appropriate OU or security group filtered GPO as a User Logon Script.
#			5. In our case we will link in the same GPO which does the Network Drive Mappings in users section without any secuurity filtering.
#			6. So as we move on migrating more servers-print queues we willl continue to add the line item in switches secion below.
#
# VERSION HISTORY: 1.0
# 31/Mar/2013 - Initial Stable Release
# 1/Apr/2013 - Comments updated - Not to Aprilfool you -it works guys...
# 6/Apr-2013 - Logic to update the default printer updated - All good and script is now final
############################################################### ENJOY ########################################################
Clear-Host
# This procedure adds a new printer
Function InstallNewPrinter{
      Param ([string]$currentPrinter, [string]$newPrinter)

#     Write-Host "CurrentPrinter : " $currentPrinter
#     Write-Host "New Printer : " $newPrinter
#     Write-Host "Is Printer Default : " $isDefault

      #Add new Printer
      $global:net.AddWindowsPrinterConnection($newPrinter)
      
      #Add current printer to the TobeDeleted List
      $global:PrintersTobeDeleted += $currentPrinter
}
# This procedure sets the respected new printer default
Function SetPrinterDefault{

Param ([string]$defaultPrinter)

 #If current printer is default, make the new a default printer
 $global:net.SetDefaultPrinter($defaultPrinter)
}

# This procedure deletes all the old printer which were replaced by this script.
Function DeleteCurrentPrinters{

      foreach ($printerTodelete in $global:PrintersTobeDeleted)
      {
            $global:net.RemovePrinterConnection($printerTodelete)
      }
}

# Set print server name
$Printserver = "."

# This section will identify all the installed Network printer under logged in users profile using WMI
$Printers = Get-WMIObject Win32_Printer -computername $Printserver -Filter "Network=True"
# This is a blank array to store the installed Network printer under logged in users profile and pass it on
$PrintersTobeDeleted = @()
$newPrinter = ""
$defaultPrinter = ""

if($Printers)
{
      # Get Network object
      $global:net = new-Object -com WScript.Network

      foreach ($Printer in $Printers)
      {
#           Write-Host "Name: " $Printer.Name
#           Write-Host "Location: " $Printer.Location
#           Write-Host "Comment: " $Printer.Comment
#           Write-Host "DriverName: " $Printer.DriverName
#           Write-Host "Shared: " $Printer.Shared
#           Write-Host "ShareName: " $Printer.ShareName
		  
          switch ($Printer.ShareName) 
          { 
              "18HookCommRelation-C" {$newPrinter = "\\SRV-PRNT01\HK-01-C1"}
              "18HookCommRelation-M" {$newPrinter = "\\SRV-PRNT01\HK-01-M1"}
              "50BayUSRC-P" {$newPrinter = "\\SRV-PRNT02\UN-14-P1"}
              "61FrontCompSrvc-M" {$newPrinter = "\\SRV-PRNT03\UN-01-M1"}
              "61FrontIT-B" {$newPrinter = "\\SRV-PRNT03\UN-01-B1"}                            
          }
		  if ($newPrinter -ne "")
		  {
		  		if ($Printer.Default) {$defaultPrinter = $newPrinter}
				InstallNewPrinter $Printer.Name $newPrinter 
				$newPrinter = ""
		  }
      }
	SetPrinterDefault $defaultPrinter
   	DeleteCurrentPrinters
}
