# Interactive PS script adds TCP/IP port based, shared printer on 2012 R2

## Original Links

- [x] Original Technet URL [Interactive PS script adds TCP/IP port based, shared printer on 2012 R2](https://gallery.technet.microsoft.com/Interactive-PS-script-adds-fc250e9a)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Interactive-PS-script-adds-fc250e9a/description)
- [x] Download: [Download Link](Download\PrinterInstall.ps1)

## Output from Technet Gallery

PrinterInstall.ps1

Interactive script to add a TCP/IP port based printer as a shared printer on Server 2012R2.  Menu will ask user to pick Printer manufacturer and then a driver.

Required Info:

1. Printer Queue/Port name

2. IP Address for printer ( Script will ping to verify IP is alive)

3. Driver i.e Model

Queries drivers and returns a distinct list of Manufacturers,  based on that selection, then matching drivers for that manufacturer are displayed.

Sample:

Enter Printer Queue/Port Name: TEST9

Enter Printer IP Address: 10.108.14.161

Adding Queue: TEST9 with IP: 10.108.14.161 --

Press Any key to continue or Ctrl-C to quit...

Press Enter to continue...:

VERBOSE: Adding new port TEST9

Select a Printer MFG to see drivers available:

1 - Brother

2 - Canon

3 - Gestetner

4 - HP

5 - KONICA MINOLTA

6 - LANIER

7 - Microsoft

8 - NRG

9 - RICOH

10 - SHARP

11 - ThinPrint

Enter the number of the desired option: 9

Selected:  RICOH

1 - RICOH Class Driver

2 - LAN-Fax M16

3 - RICOH LAN-Fax M16

4 - RICOH Aficio SP C820DN PCL 6

5 - RICOH Aficio MP C5000 PCL 6

6 - RICOH Aficio MP C4501 PCL 6

7 - RICOH Aficio MP C2550 PCL 6

8 - RICOH Aficio MP C2050 PCL 6

9 - RICOH Aficio MP 301 PCL 6

10 - RICOH Aficio MP 171 PCL 6

11 - RICOH Aficio 1075 PCL 6

Enter the number of the desired option: 10

Selected:  RICOH Aficio MP 171 PCL 6

VERBOSE: Adding new printer TEST9

```
<#
PrinterInstall.ps1
Lien Mock  6/6/2016
Interactive script to add a TCP/IP port based printer as a shared printer on Server 2012R2.
Menu will ask user to pick Printer manufacturer and then a driver
Required Info:
1. Printer Queue/Port name
2. IP Address for printer ( Script will ping to verify IP is alive)
3. Driver i.e Model
#>
function Get-MenuInput
{
   param (
        [Parameter (Mandatory = $true)]
        [array]$Array      )
    #Note how many objects are in the array.
    #Number of menu options
    $ArrayLength = $Array.Length
   # Write-Host "Array LENGTH : $($ArrayLength)"
    #Loop validates the users input
    #Print each option in the array with a numbered choice index
    Do {
        #Reset index
        $i = 1
        #Write a line to the host for each item
        foreach ($item in $Array)
           {
            Write-host "$i - $item"
            $i++  #Increment the Choice Index
           }
        #Save choice as a variable
        $MenuChoice =  Read-Host -Prompt 'Enter the number of the desired option'
         $MenuChoice = [convert]::ToInt32($MenuChoice, 10)
       } While ($MenuChoice -lt 1 -or $MenuChoice -gt $ArrayLength)
    #Decrease by 1 to match zero-based array
    $MenuChoice = $MenuChoice - 1
    #Display the choice
    Write-Host "Selected:  $($Array[$MenuChoice])" -ForegroundColor Green
    #Return the chosen option as a string
    $Array[$MenuChoice]
} #END FUNCTION
### BEGIN
# Get Printer Manufacturer into Array
$MFGArray = Get-PrinterDriver | Select-Object -ExpandProperty Manufacturer | Sort -Unique
# Get Name and IP interactively
$PQ = Read-Host -Prompt "Enter Printer Queue/Port Name"
$IPADDR = Read-Host -Prompt "Enter Printer IP Address"
# [system.net.IPAddress]::TryParse($IPADDR,[ref]$null)
#Test IP is "LIVE"
IF (Test-Connection $IPADDR -Count 1 -Quiet)
   {
    Write-Host " Adding Queue: $($PQ) with IP: $($IPADDR) -- " -ForegroundColor Green
    Write-Host "Press Any key to continue or Ctrl-C to quit..." -ForegroundColor Yellow
    pause
    Try   { $Qexist = Get-PrinterPort -Name $PQ -ErrorAction SilentlyContinue} # check if port Name exists
    Catch { $Qexist = $null}
    # If port does not exist, create it, else continue
    If($Qexist -eq $null)
      {
        Add-PrinterPort -Name $PQ -PrinterHostAddress $IPADDR -Verbose #-WHATIf
        #Write-Host "Adding Port $($PQ)"
      }
    Else
      {
        Write-Host "Existing Queue found for $($PQ)"
      }
   }
 #If IP is not live then script will EXIT
 Else
   {
       Write-Host "Cannot PING IP: $($IPADDR)"
       EXIT 1
   }
# Verify Port was created
   Try   { $Qexist = Get-PrinterPort -Name $PQ -ErrorAction Stop}
   Catch { EXIT }
 #Add Printer
   Try { $Pexist = Get-Printer -Name $PQ -ErrorAction SilentlyContinue} # TEST if printer name exists
   Catch { $Pexist = $null }
     # If printer does not exist, create it, else continue
     If($Pexist -eq $null)
        {
            Write-Host "Select a Printer MFG to see drivers available:"
            # Get Manufactuer
            $MFG = Get-MenuInput -Array $MFGArray
            $MFG = $MFG + "*"
            # Display and get Driver based on Maufacturer
            $DriverArray = Get-PrinterDriver | where { $_.Manufacturer -like $MFG } |  select-object -ExpandProperty Name
            $Driver = Get-MenuInput -Array $DriverArray
            # Add printer
            Add-Printer -Name $PQ -DriverName $Driver -PortName $PQ -Shared -Verbose #-Whatif
            #Write-Host "Printer $($PQ) Added"
        }
     Else
        {
            # Option to create a copy of the printer - useful for different Queues for Color and B/W, or diff. paper types, etc...
            Write-Host "Existing Printer found for $($PQ)"
            Write-Host "Enter new Printer Name to reuse existing port or CTRL-C to quit:"
            $P2 = Read-Host "New Printer Name"
            $Driver = Get-Printer -Name $PQ| Select-Object -ExpandProperty DriverName
            Add-Printer -Name $P2 -DriverName $Driver -PortName $PQ -Shared -Verbose #-Whatif
        }
# END INSTALL
```

