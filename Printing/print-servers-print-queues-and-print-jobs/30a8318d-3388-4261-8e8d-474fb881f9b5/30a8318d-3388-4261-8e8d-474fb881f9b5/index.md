# Check for non healthy printers on server

## Original Links

- [x] Original Technet URL [Check for non healthy printers on server](https://gallery.technet.microsoft.com/30a8318d-3388-4261-8e8d-474fb881f9b5)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/30a8318d-3388-4261-8e8d-474fb881f9b5/description)
- [x] Download: Not available.

## Output from Technet Gallery

Checks printer que's on one or multiple servers to see if they are healthy

```
CLS
$arrayComp ="Server1"
foreach ($machine in $arrayComp)
{
get-WmiObject -class win32_printer -computername $machine |`
where-object {$_.status -notmatch "Unknown" -and $_.status -notmatch "Ok"} | sort name | ft name, systemName, shareName, status, location
}
```

