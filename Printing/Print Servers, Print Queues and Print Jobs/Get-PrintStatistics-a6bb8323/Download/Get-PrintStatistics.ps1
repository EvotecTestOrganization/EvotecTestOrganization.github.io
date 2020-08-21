<#
.SYNOPSIS 
Generates reports from a print server.

.DESCRIPTION
Parses event logs on a print server to generate reports containing information on print jobs.

.PARAMETER PrintServer
PrintServer to run the report against, if none is specified it uses the local machine.

.PARAMETER StartTime
The time to begin looking at print events.

.PARAMETER EndTime
The time to stop looking at print events.

.PARAMETER Path
The directory to save reports and logs to.

.PARAMETER JobReport
Generate a report based on print jobs. This gives the most data of any report.

.PARAMETER UserReport
Generate a report based on users.

.PARAMETER PrinterReport
Generate a report based on printer usage.

.EXAMPLE
.\Get-PrintStatistics -PrintServer 'print01.contoso.com' -UserReport

This example generates a report from print01.contoso.com on users for what has been printed since midnight.

.EXAMPLE
.\Get-PrintStatistics -StartTime (Get-Date).AddMonths(-1) -EndTime (Get-Date) -JobReport -PrinterReport

This example generates reports from the local machine with detailed job information and printer usage for the past month.

.NOTES
Author: Tyler Siegrist
Date: 12/2/2016

The PrintService Operational event log must be enabled on the print server to track printing events. This script will only be able to report on information gathered while that log is enabled.
#>
[CmdletBinding()]
Param(
   [Parameter(Position=1)]
   [string]$PrintServer='localhost',

   [Parameter(Position=2)]
   [DateTime]$StartTime = (Get-Date -Hour 0 -Minute 0 -Second 0),

   [Parameter(Position=3)]
   [DateTime]$EndTime = (Get-Date -Hour 23 -Minute 59 -Second 59),

   [Parameter()]
   [string]$Path = $pwd.Path,

   [Parameter()]
   [switch]$JobReport,

   [Parameter()]
   [switch]$UserReport,

   [Parameter()]
   [switch]$ClientReport,

   [Parameter()]
   [switch]$PrinterReport
)

$log = "$Path\Get-PrintStatistics.log"
"Get-PrintStatistics started at $(Get-Date)" | Out-File $log -Append

Write-Host "Collecting event logs found in the specified time range from $StartTime to $EndTime from $PrintServer."

#Collect print job events
$PrintEntries = Get-WinEvent -ErrorAction SilentlyContinue -ComputerName $PrintServer -FilterHashTable @{ProviderName="Microsoft-Windows-PrintService"; StartTime=$StartTime; EndTime=$EndTime; ID=307}

if (!$PrintEntries) {
    $Message = "There were no print job event ID 307 entries found in the specified time range from $StartTime to $EndTime. Exiting script."
    $Message | Out-File $log -Append
    Write-Host $Message
    Exit
}

#Corresponding events with number of copies property
$PrintCopyEntries = Get-WinEvent -ErrorAction SilentlyContinue -ComputerName $PrintServer -FilterHashTable @{ProviderName="Microsoft-Windows-PrintService"; StartTime=$StartTime; EndTime=$EndTime; ID=805}

Write-Host "Number of event ID 307 entries found:" ($PrintEntries | Measure-Object).Count
Write-Host "Number of event ID 805 entries found:" ($PrintCopyEntries | Measure-Object).Count

$jobArray = @()

ForEach ($PrintEntry in $PrintEntries) {
    try {
        $entry = [xml]$PrintEntry.ToXml()
    }
    catch {
        #Unable to read XML
        $Message = "Event log with RecordId $($PrintEntry.RecordId) has unparsable XML contents. Skipping this print job entry entirely without counting its pages and continuing on..."
        $Message | Out-File $log -Append
        Write-Error $Message
        Continue
    }

    #Get print job info
    $Job = New-Object PSObject -Property @{
        Time = $PrintEntry.TimeCreated
        ID = [int]$entry.Event.UserData.DocumentPrinted.Param1
        DocumentName = $entry.Event.UserData.DocumentPrinted.Param2
        UserName = $entry.Event.UserData.DocumentPrinted.Param3
        ClientName = $entry.Event.UserData.DocumentPrinted.Param4
        PrinterName = $entry.Event.UserData.DocumentPrinted.Param5
        Bytes = [int]$entry.Event.UserData.DocumentPrinted.Param7
        Pages = [int]$entry.Event.UserData.DocumentPrinted.Param8
        Copies = $null
        TotalPages = $null
    }

    #Find number of copies
    $PrintCopyEntry = $PrintCopyEntries | Where-Object {$_.Message -eq "Rendering job $($Job.ID)." -and $_.TimeCreated -le $Job.Time -and $_.TimeCreated -ge ($Job.Time - (New-Timespan -second 5))}
    if (($PrintCopyEntry | Measure-Object).Count -eq 1) {
        $Job.Copies = ([xml]$PrintCopyEntry.ToXml()).Event.UserData.RenderJobDiag.Copies
        if ($Job.Copies -eq 0){ #Some print drivers always report 0 copies, assume 1 copy
            $Job.Copies = 1
            $Message = "Printer $($Job.PrinterName) recorded that print job ID $($Job.ID) was printed with 0 copies. Upgrading or changing the print driver may help. Guessing that 1 copy of the job was printed and continuing on..."
            $Message | Out-File $log -Append
            Write-Warning $Message
        }
    }
    else {
        $Job.Copies = 1
        $Message = "Printer $($Job.PrinterName) recorded that print job ID $($Job.ID) had $(($PrintCopyEntry | Measure-Object).Count) matching event ID 805 entries in the search time range from $(($Job.Time - (New-Timespan -second 5))) to $($Job.Time). Logging this as a warning as only a single matching event log ID 805 record should be present. Guessing that 1 copy of the job was printed and continuing on..." 
        $Message | Out-File $log -Append
        Write-Error $Message
    }

    #Calculate total pages for job
    $Job.TotalPages = $Job.Pages * $Job.Copies

    #Log job for report
    $jobArray += $Job
}

if($JobReport) {
    $fileName = "$Path\JobReport.csv"
    $jobArray | Select Time,ID,DocumentName,UserName,ClientName,PrinterName,Bytes,Pages,Copies,TotalPages | Export-Csv $fileName -NoTypeInformation
    Write-Host "Job report saved to $fileName"
}

if($UserReport) {
    $fileName = "$Path\UserReport.csv"
    $jobArray | group UserName | Select @{n='UserName';e={$_.Name}},
        @{n='JobCount';e={$_.Group.Count}},
        @{n='Printers';e={($_.Group | select -exp PrinterName -Unique) -Join ','}},
        @{n='Clients';e={($_.Group | select -exp ClientName -Unique) -Join ','}},
        @{n='TotalBytes';e={($_.Group | select -exp Bytes | measure -Sum).Sum}},
        @{n='TotalPages';e={($_.Group | select -exp TotalPages | measure -Sum).Sum}} | sort UserName | Export-Csv $fileName -NoTypeInformation
    Write-Host "User report saved to $fileName"
}

if($ClientReport) {
    $fileName = "$Path\ClientReport.csv"
    $jobArray | group ClientName | Select @{n='Client';e={$_.Name}},
        @{n='JobCount';e={$_.Group.Count}},
        @{n='Printers';e={($_.Group | select -exp PrinterName -Unique) -Join ','}},
        @{n='Users';e={($_.Group | select -exp UserName -Unique) -Join ','}},
        @{n='TotalBytes';e={($_.Group | select -exp Bytes | measure -Sum).Sum}},
        @{n='TotalPages';e={($_.Group | select -exp TotalPages | measure -Sum).Sum}} | sort Client | Export-Csv $fileName -NoTypeInformation
    Write-Host "Client report saved to $fileName"
}

if($PrinterReport) {
    $fileName = "$Path\PrinterReport.csv"
    $jobArray | group PrinterName | Select @{n='Printer';e={$_.Name}},
        @{n='JobCount';e={$_.Group.Count}},
        @{n='Clients';e={($_.Group | select -exp ClientName -Unique) -Join ','}},
        @{n='Users';e={($_.Group | select -exp UserName -Unique) -Join ','}},
        @{n='TotalBytes';e={($_.Group | select -exp Bytes | measure -Sum).Sum}},
        @{n='TotalPages';e={($_.Group | select -exp TotalPages | measure -Sum).Sum}} | sort Printer | Export-Csv $fileName -NoTypeInformation
    Write-Host "Printer report saved to $fileName"
}

"Get-PrintStatistics finished at $(Get-Date)" | Out-File $log -Append