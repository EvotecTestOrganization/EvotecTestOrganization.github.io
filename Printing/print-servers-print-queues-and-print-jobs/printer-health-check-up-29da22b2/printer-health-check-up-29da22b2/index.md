# Printer Health Check Up Repor

## Original Links

- [x] Original Technet URL [Printer Health Check Up Repor](https://gallery.technet.microsoft.com/Printer-Health-Check-Up-29da22b2)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Printer-Health-Check-Up-29da22b2/description)
- [x] Download: [Download Link](Download\Printer_Monitor.ps1)

## Output from Technet Gallery

This script is done for team one who monitors the printers across the networks. This report will provide you the below status

1. Printer Full Name

2. Location (Provided if its updated in comment or in Location)

3. Description of the Printer

4. Identifies the Paper Problem

5. Check Toner Status

6. Check Toner Availability

7. Printer Door Issues

8. Availability

9. Power Saving Mode

10. Queue Status

11. Any Error Mode

12. Out Of Paper

13. Any User Intervention Required?

14. Paper Jam

15. Number of Jobs

Team can execute the report before business day and avoid opertional tickets. You can customize the script as per your requirement

Note: I opted .NET class to fetch printer information

```
<#
Refer Usage at line 55
#>
Function Get-PrinterInformation{
[cmdletBinding()]
param(
        [parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelinebypropertyName=$true,
                   helpmessage="Provide Print Server Name")]
        [String[]]$PrintServerName,
        [parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelinebypropertyName=$true,
                   helpmessage="Provide Printer Name")]
        [String[]]$PrinterName
        )
BEGIN {}
PROCESS {
Add-Type -AssemblyName System.printing
$PrintServer = New-Object System.Printing.PrintServer("\\$($PrintServerName)")
foreach($printer in $PrinterName){
$printerinformation = $PrintServer.GetPrintQueue($printer)
$property = @{'Printer Name' = $printer;
              'Printer Full Name' = $printerinformation.FullName;
              'Location' = $printerinformation.Comment;
              'Description' = $printerinformation.Description;
              'Paper Problem'= $printerinformation.HasPaperProblem;
              'Toner Available' = $printerinformation.HasToner;
              'Door Issues' = $printerinformation.IsDoorOpened;
              'Is Not Available'= $printerinformation.IsNotAvailable;
              'Is PowerSaver On' = $printerinformation.IsPowerSaveOn;
              'Is Toner Low' = $printerinformation.IsTonerLow;
              'Queue Status' = $printerinformation.QueueStatus;
              'Is in Error' = $printerinformation.IsInError;
              'Is Manual Feed Required' = $printerinformation.IsManualFeedRequired;
              'Is Out Of Paper' = $printerinformation.IsOutOfPaper;
              'Need Intervention' = $printerinformation.NeedUserIntervention;
              'Is Paper Jammed' = $printerinformation.IsPaperJammed;
              'Default Priority' = $printerinformation.DefaultPriority;
              'Is Printing' = $printerinformation.IsPrinting;
              'Number Of Jobs' = $printerinformation.NumberOfJobs;}
              $object = New-Object -TypeName PSObject -Property $property
              Write-Output $object
}
}
END {}
}
<#
    .USAGE
    Get-PrinterInformation -PrintServerName 'Something' -PrinterName $PrinterList | Export-Csv C:\PrintInfo.csv - For Multiple Printers from Sam
    Get-PrinterInformation -PrintServerName 'Something' -PrinterName 'Something'
    $html = Get-PrinterInformation -PrintServerName 'Something' -PrinterName 'Something' | ConvertTo-Html -Fragment
    ConvertTo-Html -Body $html -CssUri C:\style.CSS | Out-File C:\Temp\File.html
    Invoke-Item C:\Temp\File.Html
    Note: You can use NET VIEW PRINTSERVERNAME to get the list. More Precise Open CMD prompt and type Net View "PRINTSERVERNAME" | find /i "Print"
#>
```

