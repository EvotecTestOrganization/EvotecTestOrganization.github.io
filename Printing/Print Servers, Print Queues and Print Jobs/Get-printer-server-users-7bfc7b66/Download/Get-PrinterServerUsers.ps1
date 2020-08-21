function Get-PrinterServerUsers {
 <#
  .SYNOPSIS
  List all users that have printed from specified printerservers the last xxx days.
  .DESCRIPTION
  The function creates a list of all users that have used specified printerservers. 
  To be able to collect the events you need to log spooler information events.
  .PARAMETER Computername
  A single computer name or an array of computer names. You may also provide IP addresses.
  .PARAMETER days
  The number of days from todays date you whant to list. 
  .EXAMPLE
  Get-PrinterServerUsers -computername srv-print01, srv-print02 -days 90

  Description
  -----------
  This will collect all the users that have prited from a printer through the servers 
  srv-print01 and srv-print02 the last 90 days, and export them to a textfile with the
  servername located at c:\temp.
  .LINK
  http://Powerhell.nu
  .NOTES
  Function by Viktor Lindström 
  v1.0 - 12/19/2014
  #>

param(
[parameter(mandatory=$true)]
[array]
$Computername,

[parameter()]
[int]
$days
)    

$date = get-date
$tempdir = "c:\temp"

#Check if directory c:\temp exist, and if not create it.
if ( -Not (Test-Path $tempdir))
 { New-Item -Path $tempdir -ItemType Directory
 }


foreach ($server in $computername)
{Write-Host collecting users from $server
$Duration = Measure-Command {
$users = get-eventlog -ComputerName $server -LogName  system  -After $date.AddDays(-$days) | where {$_.eventID -eq 10} | select UserName
$unique = $users | Sort-Object username | Get-Unique -AsString
$unique | Export-Csv c:\temp\$server.txt -NoTypeInformation }
Write-host "$($Server) done in $($Duration.Minutes):$($Duration.Seconds) mm:ss"
    }
    }