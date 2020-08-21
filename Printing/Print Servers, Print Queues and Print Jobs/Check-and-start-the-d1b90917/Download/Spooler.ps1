$servers = Import-Csv c:\!\script\serversSpool.csv
foreach ($server in $servers) {
$a = (Get-Service -Computer $server.ServerName -Name spooler | where {$_.Status -eq "Stopped"})
if (!$a) {"The spooler is running on "+$server.ServerName} else {Start-Service -InputObject $a;"The spooler was startet on "+$server.ServerName}
}