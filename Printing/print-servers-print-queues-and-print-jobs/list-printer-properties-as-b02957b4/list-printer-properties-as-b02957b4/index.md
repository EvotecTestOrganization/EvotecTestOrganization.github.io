# List printer properties as defined in class Win32_Printer - alpha version

## Original Links

- [x] Original Technet URL [List printer properties as defined in class Win32_Printer - alpha version](https://gallery.technet.microsoft.com/List-printer-properties-as-b02957b4)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/List-printer-properties-as-b02957b4/description)
- [x] Download: [Download Link](Download\Get-PrinterProperties.zip)

## Output from Technet Gallery

List printer properties as defined in class Win32\_Printer.

Details https://msdn.microsoft.com/en-us/library/aa394363(v=vs.85).aspx as of 08/22/17

Script uses 3 files

         1. list of servers in FQDN/IP format - d:/servers.txt

         2. Output CSV file - in script d:\output.txt

         3. Json file contains description of properties of Win32\_Printer to be displayed, PropertyValue needs to be set to TRUE

Attachment contains script and win32print.json files

```
function Get-PrinterProperties{
<#
     .SYNOPSIS
        List printer properties as defined in class Win32_Printer. Details https://msdn.microsoft.com/en-us/library/aa394363(v=vs.85).aspx as of 08/22/17
     .DESCRIPTION
        Script is using 3 files
        1. list of servers in FQDN or IP format - in script d:/servers.txt
        2. Output CSV file - in script d:\output.txt
        3. Json file contains description of properties of Win32_Printer to be displayed, PropertyValue needs to be set to true - in script winprint32.json
     .PARAMETER
        No Parameters
     .NOTES
        Author  : John Gakhokidze
        Requires:     PowerShell Version 2.0, Remote Registry
        Version: 0.1 Alpha
        DateUpdated: 08/22/2017
     .LINK
        https://gallery.technet.microsoft.com/scriptcenter/List-printer-properties-as-b02957b4
     .EXAMPLE
     Get-PrinterProperties
    #>
PARAM(
)
BEGIN {
$servers = get-content "d:\servers.txt"
$scanresult ="d:\output.txt"
$json_file=get-content "d:\winprint32.json" -Raw
$json_object=ConvertFrom-Json  -InputObject $json_file
[string[]]$variables=@()
$arrayindex=0
$output=''
Clear-Content -Path $scanresult
foreach ($n in $json_object.winprint32){
if ($n.Value -like 'TRUE'){
$intermediateValue=$n.PrinterProperty
$variables=$variables+$intermediateValue
$arrayindex=$arrayindex+1
}
}
function write_headers {
$n=0
$output="Printer Name;Port Name;Port HostAddress;Is Port Pingable"
While  ($n -lt  $arrayindex){
           $intermediateValue=$variables[$n]
           $output=$output+";"+$intermediateValue
           $n=$n+1
           }
            $output=$output+"`n"
            Write-Output $output|Format-table |Out-file -FilePath $scanresult -Append
            $output=''
            $n=0
}
write_headers
}
PROCESS {
foreach ($Printserver in $servers){
$Printers = Get-WMIObject Win32_Printer -computername $Printserver
$Ports = Get-WmiObject Win32_TcpIpPrinterPort -computername $Printserver
foreach ($Printer in $Printers)
{
     foreach ($Port in $Ports)
        {
        $n=0
            if ($Port.Name -eq $Printer.PortName)
            {
           $ok = Test-Connection $Port.HostAddress -Count 1 -Quiet
           #Write-Host $Printer.Name+","+$Port.Name+","+$Port.HostAddress+","+$ok+","
           $output=$Printer.Name+";"+$Port.Name+";"+$Port.HostAddress+";"+$ok
           While  ($n -lt  $arrayindex){
           $intermediateValue=$variables[$n]
           $output=$output+";"+$Printer.$intermediateValue
           $n=$n+1
           }
            $output=$output+"`n"
            Write-Output $output|Format-table |Out-file -FilePath $scanresult -Append
            $output=''
            }
            }
        }
}
}
END {
        #Write-Host "Script completed"
    }
}
```

