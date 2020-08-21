# w-PrintJob

## Original Links

- [x] Original Technet URL [w-PrintJob](https://gallery.technet.microsoft.com/New-PrintJob-2f43062f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/New-PrintJob-2f43062f/description)
- [x] Download: [Download Link](Download\New-PrintJob.ps1)

## Output from Technet Gallery

We recently migrated from a single print server, to a print cluster and this move broke our existing print logging solution. So I needed to find a way to get this information as we are routinely asked to present data on user printing. Additionally we use  the data internally to track trends, and alert users who may be abusing the printers.

This script works in conjunction with an Event Trigger on the PrintService event log on our print servers. This script requires that the Microsoft-Windows-PrintService/Operational log be enabled, so that it can query the log for Event ID 307. This event  contains the data that represents a sucessful print, and contains all of the information you might need in a print logger.

```
<#
    .SYNOPSIS
        Log a print job to a file.
    .DESCRIPTION
        This script works in conjunction with an Event Trigger on the PrintService
        event on our print servers. This script queries the Microsoft-Windows-PrintService/Operational
        log for EventID 307, and returns the drive letter from the most recent event.
        This should be the same event that triggered this script to
        run in the first place.
        It appends to a CSV log file if it exists, or creates a new file if it doesn't.
    .PARAMETER FileName
        The fully qualified path and filename for the report.
    .PARAMETER eventRecordID
        This value is passed in from the even that triggered the task. This is the
        record number of the event in the log. This is used to grab the specific
        event that the script will query data from.
    .PARAMETER eventChannel
        This is the name of the log, as passed in from the Event subsystem.
    .EXAMPLE
        .\New-PrintJob.ps1
        Description
        -----------
        This is the only syntax for this script.
    .NOTES
        ScriptName: New-PrintJob.ps1
        Created By: Jeff Patton
        Date Coded: August 17, 2011
        ScriptName is used to register events for this script
        LogName is used to determine which classic log to write to
        Microsoft .NET Framework 3.5 or greater is required.
        This script was modified to pull the record id directly from the
        event subsystem to work around an issue that is potentially caused
        from pulling in all event id's.
    .LINK
        https://code.google.com/p/mod-posh/wiki/New-PrintJob
    .LINK
        http://www.patton-tech.com/2012/04/updated-new-printjob-script.html
#>
Param
    (
    $FileName = "TEMP-PrintLog-$((get-date -format "yyyMMdd")).csv",
    $eventRecordID,
    $eventChannel
    )
Begin
    {
        $ScriptName = $MyInvocation.MyCommand.ToString()
        $LogName = "Microsoft-Windows-PrintService/Operational"
        $ScriptPath = $MyInvocation.MyCommand.Path
        $Username = $env:USERDOMAIN + "\" + $env:USERNAME
        $ErrorActionPreference = "Stop"
        New-EventLog -Source $ScriptName -LogName $LogName -ErrorAction SilentlyContinue
        $Message = "Script: " + $ScriptPath + "`nScript User: " + $Username + "`nStarted: " + (Get-Date).toString()
        Write-EventLog -LogName $LogName -Source $ScriptName -EventID "100" -EntryType "Information" -Message $Message
        #    Dotsource in the functions you need.
        }
Process
    {
        Try
        {
            $Event307 = Get-WinEvent -LogName $eventChannel -FilterXPath "<QueryList><Query Id='0' Path='$eventChannel'><Select Path='$eventChannel'>*[System[(EventRecordID=$eventRecordID)]]</Select></Query></QueryList>"
            $Event307XML = ([xml]$Event307.ToXml())
            }
        Catch
        {
            $Message = $Error[0]
            Write-Warning $Message
            Write-EventLog -LogName $LogName -Source $ScriptName -EventID "101" -EntryType "Error" -Message $Message
            Break
            }
        $Client = $Event307.Properties[3].Value
        if($Client.IndexOf("\\") -gt -1)
        {
            $Lookup = "nslookup $($Client.Substring(2,($Client.Length)-2)) |Select-String 'Name:'"
            }
        else
        {
            $Lookup = "nslookup $($Client) |Select-String 'Name:'"
            }
        Try
        {
            [string]$Return = Invoke-Expression $Lookup
            $Client = $Return.Substring($Return.IndexOf(" "),(($Return.Length) - $Return.IndexOf(" "))).Trim()
            }
        Catch
        {
            $Client = $PrintJob.Properties[3].Value
            }
        $PrintLog = New-Object -TypeName PSObject -Property @{
            Time = $Event307.TimeCreated
            Job = $Event307XML.Event.UserData.DocumentPrinted.Param1
            Document = $Event307XML.Event.UserData.DocumentPrinted.Param2
            User = $Event307XML.Event.UserData.DocumentPrinted.Param3
            Client = $Client
            Printer = $Event307XML.Event.UserData.DocumentPrinted.Param6
            Port = $Event307XML.Event.UserData.DocumentPrinted.Param5
            Size = $Event307XML.Event.UserData.DocumentPrinted.Param7
            Pages = $Event307XML.Event.UserData.DocumentPrinted.Param8
            }
        $PrintLog = $PrintLog |Select-Object -Property Size, Time, User, Job, Client, Port, PRinter, Pages, Document
        $PrintLog = ConvertTo-Csv -InputObject $PrintLog -NoTypeInformation
        }
End
    {
        if ((Test-Path -Path "P:\PrintLogs\$($FileName)") -eq $true)
        {
            $PrintLog |Select-Object -Skip 1 |Out-File -FilePath "P:\PrintLogs\$($FileName)" -Append
            }
        else
        {
            $PrintLog |Out-File -FilePath "P:\PrintLogs\$($FileName)"
            }
        $Message = "Script: " + $ScriptPath + "`nScript User: " + $Username + "`nFinished: " + (Get-Date).toString()
        Write-EventLog -LogName $LogName -Source $ScriptName -EventID "100" -EntryType "Information" -Message $Message
        }
```

