# Adding Canon Network Printers on Win8

## Original Links

- [x] Original Technet URL [Adding Canon Network Printers on Win8](https://gallery.technet.microsoft.com/Adding-Canon-Network-26f93fa5)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Adding-Canon-Network-26f93fa5/description)
- [x] Download: Not available.

## Output from Technet Gallery

Microsoft release of patch KB3170455 has caused Canon Network Printer drivers "Untrusted." I have re-written a PowerShell script that's considered a "workaround" by adding Canon Printers by IP Address until Microsoft fixes the issue or until you move to  Windows 10. If you don't use a print server then you will not be affected, but I support over 1k users and this has solved the problem until we go to Win10.

Prerequisites

-Have a print server

-Have the drivers on the print server

```
#This is the template
cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\prndrvr.vbs" -a -m "ENTER DRIVER NAME" -i "\\path_to_the_printer_inf_file"
cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prnport.vbs" -a -r IP_00.000.0.000 -h 00.000.0.000 -o raw -n 9100
cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs" -a -p "ENTER PRINTER NAME" -m "ENTER DRIVER NAME" -r "IP_00.000.0.000"
#This is an example of the completed template
cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\prndrvr.vbs" -a -m "Canon iR2318/2320 UFRII LT" -i "\\printserver\PrintDrivers\Canon\iR x64 - UFRII - 21.70\Driver\CNLB0UA64.INF"
cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\Prnport.vbs" -a -r IP_10.10.255.12 -h 10.10.255.12 -o raw -n 9100
cscript "C:\Windows\System32\Printing_Admin_Scripts\en-US\prnmngr.vbs" -a -p "IP_Canon_2318" -m "Canon iR2318/2320 UFRII LT" -r "IP_10.10.255.12"
```

 I've written a more in-depth script but it has work-related info and will not be posting it. If you are creative enough I'm sure you can automate 100% of this and even add a GUI interface like I have.

