############################################## ReadMe 
#This script creates a report of all successful print job which include: data of print document, who printed this 
# document, on which client printed this document, number of page printed and other useful information. 
# You should enable success audit logging enable on printer and then enable logging on the following directories.
# Start → Server Manager → Tools → Event Viewer → Applications and Service Logs → Microsoft → Windows → Print Service → Operational
# Then, right click on Operational and select Enable log 
##############################################
# Get the period of reporting
cls
Write-Host "************************************************************"
Write-Host "*                   Print Server Report                    *"
Write-Host "************************************************************"
$FirstDate = Read-Host -Prompt 'Enter the first day that you want generate report?
The input should be in this format, August10
'
$LastDate = Read-Host -Prompt 'Enter the last day that you want generate report?
The input should be in this format, August15
'
$File = "C:\Print Server Report\Printing Audit - " + (Get-Date).ToString("yyyy-MM-dd") +".txt"
$PrintEntries = Get-WinEvent -ea SilentlyContinue -FilterHashTable @{ProviderName="Microsoft-Windows-PrintService"; StartTime=$FirstDate; EndTime=$LastDate; ID=307}

# export the header to output file. 
write-output "Date, Document, User Name, Client, Printer Name, Print Size, Pages" | Out-File $File

# Check there is any log in event log or no!?
if ([bool]$PrintEntries -eq $true){
 # Print the header of output
 Write-Host "************************** Report ***********************************"
 Write-Host "Date| Document| User Name| Client| Printer Name| Print Size| Pages"
 Write-Host ""
ForEach ($PrintEntry in $PrintEntries)
 { 

 # Get Detail of each Print log
 $Date_Time = $PrintEntry.TimeCreated
 $entry = [xml]$PrintEntry.ToXml() 
 $docName = $entry.Event.UserData.DocumentPrinted.Param2
 $Username = $entry.Event.UserData.DocumentPrinted.Param3
 $Client = $entry.Event.UserData.DocumentPrinted.Param4
 $PrinterName = $entry.Event.UserData.DocumentPrinted.Param5
 $PrintSize = $entry.Event.UserData.DocumentPrinted.Param7
 $PrintPages = $entry.Event.UserData.DocumentPrinted.Param8
  # Output
 $output= "$Date_Time, $docName, $Username, $Client, $PrinterName, $PrintSize bytes, $PrintPages "
  $output | Out-File $File -append
 Write-Host "$output"
 }
 # Print the footer of output
 Write-Host ""
 Write-Host "********************* Successfully Exported! *************************"
 }else

 # if there is no successful print in event log, show No log 
{
Write-Host "*************************************************************"
Write-Host "*                          No Log                           *"
Write-Host "*************************************************************"
} 
Write-Host -NoNewLine 'Press any key to exit...';
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');