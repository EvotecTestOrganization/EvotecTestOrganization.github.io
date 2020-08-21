# Add a New Default printer

## Original Links

- [x] Original Technet URL [Add a New Default printer](https://gallery.technet.microsoft.com/9e52c5e2-cd0f-413b-acad-a010b031d44d)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/9e52c5e2-cd0f-413b-acad-a010b031d44d/description)
- [x] Download: Not available.

## Output from Technet Gallery

**Submitted By: **Antonio Luiz Camêlo Chaves

Adds a network printer and sets it as the default printer.

Visual Basic

```
@Echo Off
REM Change \\COMPUTER\PRINTER by your printer's UNC  

REM Add printer
rundll32 printui.dll,PrintUIEntry /in /n\\COMPUTER\PRINTER

REM Set printer as default
rundll32 printui.dll,PrintUIEntry /y /n\\COMPUTER\PRINTER
```

