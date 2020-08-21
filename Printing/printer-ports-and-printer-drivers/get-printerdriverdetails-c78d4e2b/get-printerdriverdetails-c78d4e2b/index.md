# Get-PrinterDriverDetails

## Original Links

- [x] Original Technet URL [Get-PrinterDriverDetails](https://gallery.technet.microsoft.com/Get-PrinterDriverDetails-c78d4e2b)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Get-PrinterDriverDetails-c78d4e2b/description)
- [x] Download: [Download Link](Download\Get-PrinterDriverDetails.zip)

## Output from Technet Gallery

.SYNOPSIS

        List printers, drivers by Architecture, driver mode available on print server, using gmi

     .DESCRIPTION

        Script is using 2 files

        1. list of servers in FQDN or IP format - in script d:/servers.txt

        2. Output CSV file - in script d:\output.txt

     .PARAMETER

        No Parameters

     .NOTES

        Author  : John Gakhokidze

        Requires:     PowerShell Version 2.0,

        Version: 0.1 Alpha

        DateUpdated: 01/24/2018

        a. Itanium architecture is metioned as placeholder, I do not have access to Itanium to actually check, what is in driver name

     .LINK

        https://gallery.technet.microsoft.com/scriptcenter/Get-PrinterDriverDetails-c78d4e2b

     .EXAMPLE

     Get-PrinterDriverDetails

    #&gt;

```
function Get-PrinterDriverDetails{
<#
     .SYNOPSIS
        List printers, drivers by Architecture, driver mode available on print server, using gmi
     .DESCRIPTION
        Script is using 2 files
        1. list of servers in FQDN or IP format - in script d:/servers.txt
        2. Output CSV file - in script d:\output.txt
     .PARAMETER
        No Parameters
     .NOTES
        Author  : John Gakhokidze
        Requires:     PowerShell Version 2.0,
        Version: 0.1 Alpha
        DateUpdated: 01/24/2018
        a. Itanium architecture is metioned as placeholder, I do not have access to Itanium to actually check, what is in driver name
     .LINK
        https://gallery.technet.microsoft.com/scriptcenter/Get-PrinterDriverDetails-c78d4e2b
     .EXAMPLE
     Get-PrinterDriverDetails
    #>
PARAM(
)
BEGIN {
 $servers = get-content "d:\servers.txt"
 $scanresult ="d:\output.txt"
 Clear-Content -Path $scanresult
 $output="Server;Printer Name;Driver;Driver Mode;x64;x86;Itanium;"
  Write-Output $output|Format-table |Out-file -FilePath $scanresult -Append
 $output=''
 $name = @{} # Driver name
 $mode = @{} # Driver mode
 $platform = @{} # Driver architecture
 }
 PROCESS {
 foreach ($Printserver in $servers){
        $wmi_drivers=get-wmiobject  Win32_PrinterDriver -Property Name -ComputerName $Printserver
        $Printers = Get-WmiObject Win32_Printer -ComputerName $Printserver
        $count=0
 # Getting all printer drivers installed on server
        foreach ($driver in $wmi_drivers) {
            $name[$count],$mode[$count],$platform[$count] = $driver.Name -split ','
            $count=$count+1
        }
        $Scount=$name.Count
 # Getting printers and matching to drivers installed on server
   ForEach ($Printer in $Printers) {
    $count=0
    $output=''
    $x64=''
    $x86=''
    $Itanium=''
    $GotDriver=''
        for ($count=0;$count -lt $Scount;$count++) {
           if ($Printer.DriverName -eq $name[$count]){
              if (!$GotDriver){
                  $output=$Printserver+';'+$Printer.Name+";"+$name[$count]+";"+$mode[$count]+";"
                  $GotDriver='TRUE'
                  }
               switch ($platform[$count]){
                    {$platform[$count].Contains('x64')}
                    {$x64=$platform[$count]}
                    {$platform[$count].Contains('x86')}
                    {$x86=$platform[$count]}
                    {$platform[$count].Contains('Itanium')}
                    {$Itanium=$platform[$count]}
                    }
              }
          }
            $output=$output+$x64+';'+$x86+';'+$Itanium+';'
            Write-Output $output|Format-table |Out-file -FilePath $scanresult -Append
    }
}
}
END {
        Write-Host "Script completed"
    }
    }
```

