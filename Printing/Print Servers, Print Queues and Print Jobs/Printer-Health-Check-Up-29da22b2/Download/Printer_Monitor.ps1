<#
Refer Usage at line 55
#>
Function Get-PrinterInformation{

[cmdletBinding()]
param(
		[parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelinebypropertyName=$true,
                   helpmessage="Provide Print Server Name")]
        [String[]]$PrintServerName,

        [parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelinebypropertyName=$true,
                   helpmessage="Provide Printer Name")]
        [String[]]$PrinterName
        )


BEGIN {}
PROCESS {
Add-Type -AssemblyName System.printing
$PrintServer = New-Object System.Printing.PrintServer("\\$($PrintServerName)")
foreach($printer in $PrinterName){
$printerinformation = $PrintServer.GetPrintQueue($printer)
$property = @{'Printer Name' = $printer;
              'Printer Full Name' = $printerinformation.FullName;
              'Location' = $printerinformation.Comment;
              'Description' = $printerinformation.Description;
              'Paper Problem'= $printerinformation.HasPaperProblem;
              'Toner Available' = $printerinformation.HasToner;
              'Door Issues' = $printerinformation.IsDoorOpened;
              'Is Not Available'= $printerinformation.IsNotAvailable;
              'Is PowerSaver On' = $printerinformation.IsPowerSaveOn;
              'Is Toner Low' = $printerinformation.IsTonerLow;
              'Queue Status' = $printerinformation.QueueStatus;
              'Is in Error' = $printerinformation.IsInError;
              'Is Manual Feed Required' = $printerinformation.IsManualFeedRequired;
              'Is Out Of Paper' = $printerinformation.IsOutOfPaper;
              'Need Intervention' = $printerinformation.NeedUserIntervention;
              'Is Paper Jammed' = $printerinformation.IsPaperJammed;
              'Default Priority' = $printerinformation.DefaultPriority;
              'Is Printing' = $printerinformation.IsPrinting;
              'Number Of Jobs' = $printerinformation.NumberOfJobs;}
              
              $object = New-Object -TypeName PSObject -Property $property
              Write-Output $object
}
}

END {}
}

<#
    .USAGE
    Get-PrinterInformation -PrintServerName 'Something' -PrinterName $PrinterList | Export-Csv C:\PrintInfo.csv - For Multiple Printers from Sam
    
    Get-PrinterInformation -PrintServerName 'Something' -PrinterName 'Something' 

    $html = Get-PrinterInformation -PrintServerName 'Something' -PrinterName 'Something' | ConvertTo-Html -Fragment
    ConvertTo-Html -Body $html -CssUri C:\style.CSS | Out-File C:\Temp\File.html
    Invoke-Item C:\Temp\File.Html

    Note: You can use NET VIEW PRINTSERVERNAME to get the list. More Precise Open CMD prompt and type Net View "PRINTSERVERNAME" | find /i "Print" 

#>
