
Function Get-PrintServers {
[System.Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic') | Out-Null

$ServerName =
$First = [Microsoft.VisualBasic.Interaction]::InputBox("Type the first server name to compare printer information", "Printer Server Number One")
$Second = [Microsoft.VisualBasic.Interaction]::InputBox("Type the second server name to compare printer information", "Print Server Number Two")  


$Computers = "$($First)","$($Second)"
foreach($computer in $Computers)
    {
        
        $PrinterNames = Get-Printer -ComputerName $computer| Select Name,DriverName
        $csvexport = "C:\Users\$ENV:USERNAME\Desktop\$($computer)_Printer_Results.csv"
        foreach($PrinterName in $PrinterNames)
            {
                $DriverName = $PrinterName.DriverName
                $Printers = Get-PrinterDriver -ComputerName $computer|?{$_.Name -eq $PrinterName.DriverName}| Select-Object Name,@{n="DriverVersion";e={ 
                        $ver = $_.DriverVersion 
                        $rev = $ver -band 0xffff 
                        $build = ($ver -shr 16) -band 0xffff 
                        $minor = ($ver -shr 32) -band 0xffff 
                        $major = ($ver -shr 48) -band 0xffff 
                        "$major.$minor.$build.$rev" }}
                
                        foreach($Printer in $Printers)
                            {
                                $hash = @{ "Server" = $computer
                                   "PrinterName" = $PrinterName.Name
                                   "DriverName" = $PrinterName.DriverName
                                   "DriverVersion" = $Printer.DriverVersion}
                                   $newRow = New-Object PsObject -Property $hash
                                   $newRow|Select Server,PrinterName,DriverName,DriverVersion|Export-CSV $csvexport -Append -Force -NoTypeInformation
                            }
            }
    $CSV = Import-CSV $csvexport|Sort PrinterName -Unique
    $CSV|Out-GridView -Title "$computer Printers"
    Remove-Variable hash
    Remove-Variable newRow
    Remove-Item $csvexport -Force
    
    }
}