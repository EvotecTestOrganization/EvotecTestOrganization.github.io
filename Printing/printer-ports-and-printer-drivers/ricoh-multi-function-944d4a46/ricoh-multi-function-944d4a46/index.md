# Ricoh Multi Function Printer (MFP) Address Book PowerShell Module 2.0

## Original Links

- [x] Original Technet URL [Ricoh Multi Function Printer (MFP) Address Book PowerShell Module 2.0](https://gallery.technet.microsoft.com/Ricoh-Multi-Function-944d4a46)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Ricoh-Multi-Function-944d4a46/description)
- [x] Download: [Download Link](Download\RICOH-MFP-AB.psm1)

## Output from Technet Gallery

Original: https://gallery.technet.microsoft.com/scriptcenter/Ricoh-Multi-Function-27aeea71

This adds the ability to specify Network Share Destinations. You may notice that I didn't flesh out the ability to specify a username and password for the shares. I did this intentionally as Ricoh/Savin devices have the ability to use a default set of credentials  specified under Configuration-&gt;File Transfer. Generally I create a single service account for a scanner and give that account write access to the target share so the copy machine doesn't need to have a copy of everyone's credentials.

## Basic Sample

```
Import-Module RICOH-MFP-AB
# Connect
Connect-MFP -Hostname 10.19.1.200 -Username admin -Password ""
# Get all entries
$AB = Get-MFPAB
# Remove all existing entries
Remove-MFPAB -ID $AB.ID
# Add single entry
Add-MFPAB -Name "Darren" -sender $false -LongName "Darren K" -FolderPath "\\DARREN-LPTP\Scans" -MailAddress "darren@contoso.com"
# Disconnect
Disconnect-MFP
```

##  Advanced Usage

```
# This will find all users in Active Directory and add them to all IP Printers
# This of course assumes you only have Ricoh devices mapped to the server. You can filter that out more cleverly if you desire or use a static list of IP addresses
# It will also attempt to find computers they login to and assume a \Scan share exists and create a destination entry for that.
Import-Module RICOH-MFP-AB
$IPPrinters = Get-Printer | ?{ [System.Net.IPAddress]::TryParse($_.PortName,[ref]$null)}
$Users = Get-ADUser -filter "*" -Properties * | ?{([string]::IsNullOrEmpty($_.EmailAddress)) -eq $false}
$Computers = Get-ADComputer -Filter "*"
$UsersThatMatchComputers = $Users | ?{$_.givenName -notlike ""} | %{
    $User = $_;
    $MatchingComputers = $Computers | ?{ $_.Name -like "$($User.SamAccountName)*" -or $_.Name -like "$($User.givenName)*"}
    $MatchingComputers | %{ new-object psobject -Property @{Computer=$_;User=$User}}
}
$UsersThatMatchComputers
foreach ($IPPrinter in $IPPrinters)
{
    $MFP = @{Hostname=$IPPrinter.Portname;UserName="admin";Password="";Authentication="BASIC"}
    Connect-MFP @MFP
    $AB = Get-MFPAB
    if($AB)
    {
        Remove-MFPAB -ID $AB.ID
    }
    foreach ($MatchObject in $UsersThatMatchComputers)
    {
        try
        {
            Add-MFPAB -Name $MatchObject.User.givenName -sender $false -LongName $MatchObject.User.DisplayName -FolderPath "\\$($MatchObject.computer.name)\Scans" -MailAddress $MatchObject.user.EmailAddress
        }
        catch
        {
            Write-Warning "Error adding $($MatchObject.User.DisplayName) to $($IPPrinter.PortName) ($($IPPrinter.Name))"
        }
    }
    Disconnect-MFP
}
```

