# Delete Old Print queues on Print Servers.

## Original Links

- [x] Original Technet URL [Delete Old Print queues on Print Servers.](https://gallery.technet.microsoft.com/Delete-Old-Print-queues-on-a1fedd43)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Delete-Old-Print-queues-on-a1fedd43/description)
- [x] Download: [Download Link](Download\publishedPrinterqueuedeletion.ps1)

## Output from Technet Gallery

This is a simple script to remove old print queues on a server(s) that you may have. It allows you to remove from multiple servers all you will need to do is create a csv file with server and DNS name of printer. Please contact me with any questions that  you may have regarding it. This is my first script being published on here so any feedback would be helpful.

```
$InCSVPath = "C:\Temp\printerstodelete.csv"
$csv = Import-Csv $InCSVPath
foreach($item in $csv){
       $server = $item.Server + ".YourDomain"
       $printer = $item.Printer
       $a = Get-WmiObject Win32_Printer -ComputerName $server -Filter "Name='$printer'"
        if($a){
             "Deleting Printer: " + $a.Name #
              $a.Delete()
         }
         else{
               "could not delete: "+$printer
         }
}
```

