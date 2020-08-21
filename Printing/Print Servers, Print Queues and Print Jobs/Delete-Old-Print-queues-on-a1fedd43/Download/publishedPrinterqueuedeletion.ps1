$InCSVPath = "C:\Temp\printerstodelete.csv" 
$csv = Import-Csv $InCSVPath 

foreach($item in $csv){ 
       $server = $item.Server + "YourDomain"
    $printer = $item.Printer
    $a = Get-WmiObject Win32_Printer -ComputerName $server -Filter "Name='$printer'"
    if($a){
        "Deleting Printer: " + $a.Name 
#        $a.Delete()
    }
    else{
        "could not delete: "+$printer
    }
} 
