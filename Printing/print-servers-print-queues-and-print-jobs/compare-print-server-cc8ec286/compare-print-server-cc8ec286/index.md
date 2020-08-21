# Compare Print Server Queues and Drivers

## Original Links

- [x] Original Technet URL [Compare Print Server Queues and Drivers](https://gallery.technet.microsoft.com/Compare-Print-Server-cc8ec286)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Compare-Print-Server-cc8ec286/description)
- [x] Download: [Download Link](Download\get-printerqueues.ps1)

## Output from Technet Gallery

# Compare Print Server Queues and Drivers

```
### Authored by David Dubuque ###
Function get-printserverqueues {
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null
$ServerName =
$First = [Microsoft.VisualBasic.Interaction]::InputBox("Type the first server name to compare printer information", "Printer Server Number One")
$Second = [Microsoft.VisualBasic.Interaction]::InputBox("Type the second server name to compare printer information", "Print Server Number Two")
$Computers = "$($First)","$($Second)"
foreach($computer in $Computers)
    {
        $PrinterNames = Get-Printer -ComputerName $computer| Select Name,DriverName
        $csvexport = "C:\Users\$ENV:USERNAME\Desktop\$($computer)_Printer_Results.csv"
        foreach($PrinterName in $PrinterNames)
            {
                $DriverName = $PrinterName.DriverName
                $Printers = Get-PrinterDriver -ComputerName $computer|?{$_.Name -eq $PrinterName.DriverName}| Select-Object Name,@{n="DriverVersion";e={
                        $ver = $_.DriverVersion
                        $rev = $ver -band 0xffff
                        $build = ($ver -shr 16) -band 0xffff
                        $minor = ($ver -shr 32) -band 0xffff
                        $major = ($ver -shr 48) -band 0xffff
                        "$major.$minor.$build.$rev" }}
                        foreach($Printer in $Printers)
                            {
                                $hash = @{ "Server" = $computer
                                   "PrinterName" = $PrinterName.Name
                                   "DriverName" = $PrinterName.DriverName
                                   "DriverVersion" = $Printer.DriverVersion}
                                   $newRow = New-Object PsObject -Property $hash
                                   $newRow|Select Server,PrinterName,DriverName,DriverVersion|Export-CSV $csvexport -Append -Force -NoTypeInformation
                            }
            }
    $CSV = Import-CSV $csvexport|Sort PrinterName -Unique
    $CSV|Out-GridView -Title "$computer Printers"
    Remove-Variable hash
    Remove-Variable newRow
    Remove-Item $csvexport -Force
    }
}
```

## Purpose

This sfunction  is something I built to provide a friendlier output while comparing two print servers queues and the drivers associated.  The company I work for has been migrating our file and print services from Windows Server 2008 R2 to Windows  Server 2012 R2.  This has been extremely helpful in verifying queue names, and drivers match up.

## Usage

When running you define two servers to compare.  It really doesn't matter which is first or second, both will have an output.  The reason I have the process generate CSV files for re-importing the data, is that if you want to keep record of the  comparision, you can modift the script to not delete the CSV files, once it opens the out-grid.  There are more efficient ways to handle this data, however creating CSV's was done on purpose.

## Note

This works with both server 2008 R2 and 2012 R2

remove the function line and brackets to use as a standalone script.

You must be an administrator of both boxes, with manage permission over each queue in order to query the information.

## Outputs

Below are the expected inputs and outputs.

![](Images\server_1.jpg)

![](Images\server_2.jpg)

![](Images\server_comparison.jpg)

