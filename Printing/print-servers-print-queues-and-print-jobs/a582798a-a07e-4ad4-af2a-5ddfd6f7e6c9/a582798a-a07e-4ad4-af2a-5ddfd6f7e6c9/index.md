# Find Spooler status on remote print servers

## Original Links

- [x] Original Technet URL [Find Spooler status on remote print servers](https://gallery.technet.microsoft.com/a582798a-a07e-4ad4-af2a-5ddfd6f7e6c9)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/a582798a-a07e-4ad4-af2a-5ddfd6f7e6c9/description)
- [x] Download: Not available.

## Output from Technet Gallery

Find Spooler status on remote print servers

```
$computers = "Server1", "Server2", "Server3"
Get-WmiObject -computer $computers Win32_Service -Filter "Name='Spooler'" | ft systemname, name, state
```

