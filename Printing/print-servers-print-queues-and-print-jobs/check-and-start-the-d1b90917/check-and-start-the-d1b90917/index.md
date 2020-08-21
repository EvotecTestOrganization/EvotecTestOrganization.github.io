# Check and start the spooler servi

## Original Links

- [x] Original Technet URL [Check and start the spooler servi](https://gallery.technet.microsoft.com/Check-and-start-the-d1b90917)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Check-and-start-the-d1b90917/description)
- [x] Download: [Download Link](Download\Spooler.ps1)

## Output from Technet Gallery

We recently went through at terrible period of printing problems in our Citrix-farm. The spooler service crashed on 20 servers every 5 minutes. The script checks if the spooler service is running on each server listed in a csv-file. If the service isn’t running the script will start it. You need to run the script with a user which have admin privileges on the targeted servers.

List the servernames in a csv-file named serversSpool.csv within the same folder as the script. Heading ServerName, new line for each server.

Ooops, I made a itsy bitsy teeny weeny mistake in my script file. The first line should read: $servers = Import-Csv .\serversSpool.csv

```
$servers = Import-Csv .\serversSpool.csv
foreach ($server in $servers) {
$a = (Get-Service -Computer $server.ServerName -Name spooler | where {$_.Status -eq "Stopped"})
if (!$a) {"The spooler is running on "+$server.ServerName} else {Start-Service -InputObject $a;"The spooler was startet on "+$server.ServerName}
}
```

 After a while I got tired of running the script manually so i added a timer function. Found it in a script from mck74 and mjolinor. Since I'm not the author of all the code, only the old script is uploaded

The new script:

```
# Timer code from mck74 and mjolinor
$timer = [System.Diagnostics.Stopwatch]::StartNew()
$run_interval = 5
$run_pass = {
$timer.reset()
$timer.start()
$servers = Import-Csv .\serversSpool.csv
foreach ($server in $servers) {
$a = (Get-Service -Computer $server.ServerName -Name spooler | where {$_.Status -eq "Stopped"})
if (!$a) {"The spooler is running on "+$server.ServerName} else {Start-Service -InputObject $a;"The spooler was startet on "+$server.ServerName}
}
} #End of code that should run
#run the first pass
$start_pass = Get-Date
&$run_pass
#if $run_interval is set, calculate how long to sleep before the next pass
while ($run_interval -gt 0){
if ($run_interval -eq "C"){&$run_pass}
 else{
 $last_run = (Get-Date) - $start_pass
 $sleep_time = ([TimeSpan]::FromMinutes($run_interval) - $last_run).totalseconds
 Write-Host "`n$("*"*10) Sleeping for $($sleep_time) seconds `n"
#sleep, and then start the next pass
 Start-Sleep -seconds $sleep_time
 $start_pass = Get-Date
 &$run_pass
 }
 }
```

 $run\_interval is the time between the execution of the code in minutes. If set to C it runs in continuous loop, if set to 0 it runs once.

