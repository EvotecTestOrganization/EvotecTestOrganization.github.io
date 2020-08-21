# Get Printer Port IP's and Open a Web Page to The Printer

## Original Links

- [x] Original Technet URL [Get Printer Port IP's and Open a Web Page to The Printer](https://gallery.technet.microsoft.com/Get-Printer-Port-IPs-and-32fe9e5f)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Get-Printer-Port-IPs-and-32fe9e5f/description)
- [x] Download: Not available.

## Output from Technet Gallery

This script find all port addresses that are on the print server that are alive, then opens that address in a web page. Beware, if you have a hundred printer ports, it will open 100 IE windows! Handy for opening a lot of print admin pages to change settings  on the printers. This may save you time if you aren't certain all the IP addresses of your printers on your network. I am not an expert scripter but this was fun and saved me a lot of time manually looking up port configurations and opening printer admin web  pages...

```
#set $printserver to be your print server host name
$printserver= "print-server-hostname"
#Get the port addresses using WMI commandlet, and loop through each one
$Ports = Get-WmiObject Win32_TcpIpPrinterPort -computername $printserver
        foreach ($Port in $Ports)
        {
            # next line checks if the printer is actually up on the network and if so continues
           if (test-connection $port.hostaddress -count 1 -quiet)
           {
                #next line just lists the printer ip address on the screen
                $port.hostaddress
                #next three lines calls up IE, navigates to the web page, and makes it visible.
                $ie = New-Object -ComObject InternetExplorer.Application
                $ie.Navigate($port.hostaddress)
                $ie.Visible = $true
            }
        }
```

