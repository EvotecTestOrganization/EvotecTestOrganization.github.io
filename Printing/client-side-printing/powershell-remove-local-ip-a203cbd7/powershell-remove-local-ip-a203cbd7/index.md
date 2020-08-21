# Powershell Remove Local IP printers

## Original Links

- [x] Original Technet URL [Powershell Remove Local IP printers](https://gallery.technet.microsoft.com/Powershell-Remove-Local-IP-a203cbd7)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Powershell-Remove-Local-IP-a203cbd7/description)
- [x] Download: Not available.

## Output from Technet Gallery

This will look for printers with a port name of 192.168.1.xx or 192.168.1.xxx, and remove any/all of them.  I don't have any printers in my environment in the 192.168.1-9 range so I didn't put that in.

Tested and working on Win 7 x64

Get-WmiObject -ComputerName localhost -Class Win32\_printer |

where { $\_.portname -like '192.168.1.\*\*' -or $\_.portname -like '192.168.1.\*\*\*' -and $\_.local -eq 'TRUE'} |

Select -ExpandProperty Name |

ForEach-Object { rundll32 printui.dll,PrintUIEntry /dl /n "$\_" }

```
Get-WmiObject -ComputerName localhost -Class Win32_printer |
where { $_.portname -like '192.168.1.**' -or $_.portname -like '192.168.1.***' -and $_.local -eq 'TRUE'} |
Select -ExpandProperty Name |
ForEach-Object { rundll32 printui.dll,PrintUIEntry /dl /n "$_" }
```

