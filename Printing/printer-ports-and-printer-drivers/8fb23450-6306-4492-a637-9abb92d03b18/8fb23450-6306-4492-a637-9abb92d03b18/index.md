# Adds a printer to a print server

## Original Links

- [x] Original Technet URL [Adds a printer to a print server](https://gallery.technet.microsoft.com/8fb23450-6306-4492-a637-9abb92d03b18)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/8fb23450-6306-4492-a637-9abb92d03b18/description)
- [x] Download: Not available.

## Output from Technet Gallery

## Description

I have to add about twenty printers to a print server everyday. Adding the printer port, and attaching the printer to the server one at a time could possibly take the whole day.

This script asks four questions:

Tha name of the printer (which will be the port name, and the share name)

The IP address of the printer

What printer model you'll be adding, or what driver you want to use.

And the location of the printer

Additionally, the script adds the IP address and the model of the printer to the comment field.

It writes the data you specify to two files in a folder and then reads from those two files to add the printer and ports to the server.

## Script

// Click on the Insert Code Section in the toolbar to add your script.

```
#printer add script
#Created from Scripting guys example scripts and my own.
#Stephen Small
#Clears all variables if you've run the scripts before
$portname = ""
$IPaddress = ""
$driver = ""
$location = ""
#publishes the form
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$objForm = New-Object System.Windows.Forms.Form
$objForm.Text = "Printer Add"
$objForm.Size = New-Object System.Drawing.Size(400,400)
$objForm.StartPosition = "CenterScreen"
$objForm.KeyPreview = $True
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") {$driver=$objListBox.SelectedItem;$portname=$objTextBox1.Text;$IPaddress=$objTextBox2.Text;$Location=$objTextBox3.Text;$objForm.Close()}})
$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") {$Cancel=$True;$objForm.Close()}})
$OKButton = New-Object System.Windows.Forms.Button
$OKButton.Location = New-Object System.Drawing.Size(75,345)
$OKButton.Size = New-Object System.Drawing.Size(75,23)
$OKButton.Text = "OK"
$OKButton.Add_Click({$driver=$objListBox.SelectedItem;$portname=$objTextBox1.Text;$IPaddress=$objTextBox2.Text;$Location=$objTextBox3.Text;$objForm.Close()})
$objForm.Controls.Add($OKButton)
$CancelButton = New-Object System.Windows.Forms.Button
$CancelButton.Location = New-Object System.Drawing.Size(150,345)
$CancelButton.Size = New-Object System.Drawing.Size(75,23)
$CancelButton.Text = "Cancel"
$CancelButton.Add_Click({$Cancel=$True;$objForm.Close()})
$objForm.Controls.Add($CancelButton)
$objLabel1 = New-Object System.Windows.Forms.Label
$objLabel1.Location = New-Object System.Drawing.Size(10,19)
$objLabel1.Size = New-Object System.Drawing.Size(280,20)
$objLabel1.Text = "What is the Printer name?"
$objForm.Controls.Add($objLabel1)
$objTextBox1 = New-Object System.Windows.Forms.TextBox
$objTextBox1.Location = New-Object System.Drawing.Size(10,38)
$objTextBox1.Size = New-Object System.Drawing.Size(260,20)
$objForm.Controls.Add($objTextBox1)
$objLabel2 = New-Object System.Windows.Forms.Label
$objLabel2.Location = New-Object System.Drawing.Size(10,61)
$objLabel2.Size = New-Object System.Drawing.Size(280,20)
$objLabel2.Text = "What is the IP Address?"
$objForm.Controls.Add($objLabel2)
$objTextBox2 = New-Object System.Windows.Forms.TextBox
$objTextBox2.Location = New-Object System.Drawing.Size(10,80)
$objTextBox2.Size = New-Object System.Drawing.Size(260,20)
$objForm.Controls.Add($objTextBox2)
$objLabel3 = New-Object System.Windows.Forms.Label
$objLabel3.Location = New-Object System.Drawing.Size(10,280)
$objLabel3.Size = New-Object System.Drawing.Size(280,20)
$objLabel3.Text = "What is the Location?"
$objForm.Controls.Add($objLabel3)
$objLabel4 = New-Object System.Windows.Forms.Label
$objLabel4.Location = New-Object System.Drawing.Size(10,100)
$objLabel4.Size = New-Object System.Drawing.Size(280,20)
$objLabel4.Text = "Please select a Printer Model"
$objForm.Controls.Add($objLabel4)
$objListBox = New-Object System.Windows.Forms.ListBox
$objListBox.Location = New-Object System.Drawing.Size(10,120)
$objListBox.Size = New-Object System.Drawing.Size(260,20)
$objListBox.Height = 160
$objListbox.SelectionMode = "one"
[void] $objListBox.Items.Add("Canon Generic PCL6 Driver")
[void] $objListBox.Items.Add("Dell 2130cn Color Laser PCL6")
[void] $objListBox.Items.Add("Dell 2145cn Color Laser MFP")
[void] $objListBox.Items.Add("Dell 2330dn Laser Printer")
[void] $objListBox.Items.Add("Dell 5330dn Mono Laser Printer")
[void] $objListBox.Items.Add("DYMO LabelWriter 400 Turbo")
[void] $objListBox.Items.Add("HP Universal Printing PCL 6")
$objListBox.SelectedItem
$objForm.Controls.Add($objListBox)
$objTextBox3 = New-Object System.Windows.Forms.TextBox
$objTextBox3.Location = New-Object System.Drawing.Size(10,300)
$objTextBox3.Size = New-Object System.Drawing.Size(260,20)
$objForm.Controls.Add($objTextBox3)
$objForm.Topmost = $True
$objForm.Add_Shown({$objForm.Activate()})
[void] $objForm.ShowDialog()
if ($Cancel -eq $True)
{Exit}
#reset to match the name of your printserver
$printservername = "BNA-VM-PRT01"
#adds the variable content to the text files for readin
Clear-Content c:\printeraddscript\ports.txt
add-content c:\printeraddscript\ports.txt "Printserver,Portname,IPAddress"
add-content c:\printeraddscript\ports.txt $printservername","$portname","$IPaddress
Clear-Content c:\printeraddscript\printers.txt
add-content c:\printeraddscript\printers.txt "Printserver,Driver,PortName,ShareName,Location,Comment,DeviceID"
add-content c:\printeraddscript\printers.txt $printservername","$driver","$portname","$portname","$location","$IPaddress" - "$driver","$portname
#adds the printer from the text file data
function CreatePrinterPort {
$server = $args[0]
$port = ([WMICLASS]"\\$server\ROOT\cimv2:Win32_TCPIPPrinterPort").createInstance()
$port.Name = $args[1]
$port.SNMPEnabled = $true
$port.SNMPCommunity = "CHDMread"
$port.Protocol = 1
$port.Portnumber = "9100"
$port.HostAddress = $args[2]
$port.Put()
}
function CreatePrinter{
$server = $args[0]
$print = ([WMICLASS]"\\$server\ROOT\cimv2:Win32_Printer").createInstance()
$print.Drivername = $args[1]
$print.PortName = $args[2]
$print.Shared = $true
$print.Published = $true
$print.Sharename = $args[3]
$print.Location = $args[4]
$print.Comment = $args[5]
$print.DeviceID = $args[6]
$print.Put()
}
#Log File
$printers = Import-Csv c:\printeraddscript\printers.txt
$ports = Import-Csv c:\printeraddscript\ports.txt
$filename = "printeradd-{0:d2}-{1:d2}-{2:d2}.log" -f $date.month,$date.day,$date.year
$filepath = "c:\printeraddscript\"
foreach ($port in $ports){
CreatePrinterPort $port.Printserver $port.Portname $port.IPAddress
}
foreach ($printer in $printers){
CreatePrinter $printer.Printserver $printer.Driver $printer.Portname $printer.Sharename $printer.Location $printer.Comment $printer.DeviceID
$date = Get-Date; Add-Content -Path $filepath\$filename ("Printer $($portname) was added $($date)")
}
#Balloon tip on Cmplettion
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$objNotifyIcon = New-Object System.Windows.Forms.NotifyIcon
$objNotifyIcon.Icon = "C:\ProgramData\Microsoft\Device Stage\Task\{e35be42d-f742-4d96-a50a-1775fb1a7a42}\print_queue.ico"
$objNotifyIcon.BalloonTipIcon = "Info"
$objNotifyIcon.BalloonTipText = ("Your Printer" , $portname , " has been added to the server.")
$objNotifyIcon.BalloonTipTitle = "Printer add Complete"
$objNotifyIcon.Visible = $True
$objNotifyIcon.ShowBalloonTip(20000)
```

