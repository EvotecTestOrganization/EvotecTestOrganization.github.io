# get and set default printer for many users in a bulk

## Original Links

- [x] Original Technet URL [get and set default printer for many users in a bulk](https://gallery.technet.microsoft.com/get-and-set-default-608a8d19)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/get-and-set-default-608a8d19/description)
- [x] Download: [Download Link](Download\Printer_Migration_v1.1.zip)

## Output from Technet Gallery

This project was coded for the printer migration in a large environment and consist oft two scripts. The aim was to read out the default printer name of the User who is logged in and save it modified to a txt File. The modification is necessary, cause as part of the migration all printer got a new name and the Users required a valid default printer.

After this, a second txt file will be created to save the old default Printername, just to have a backup.

The second script checks out, if there is a printer installed with the new name and if this condition is true, the script will set this printer as the default one.

Skript one:

Bash/shell

```
@echo off
@REM =======================================================================================
@REM Param to set the working path
@REM =======================================================================================
SET pfad="C:\Users\%Username%\Desktop\"
wmic printer where "Default = 'True'" get Name > %pfad%old_defaultprinter.txt
setlocal enabledelayedexpansion
@REM =======================================================================================
@REM Enter here the String which should be replaced with a new one.
@REM =======================================================================================
Set "FindString=Canon"
@REM =======================================================================================
@REM Enter here the String which replace the old one.
@REM =======================================================================================
Set "ReplaceWith=Brother"
@REM =======================================================================================
@REM Replacing Process
@REM =======================================================================================
For /f "delims=" %%a in (
   'find.exe /n /v ""^<"%pfad%old_defaultprinter.txt"'
   ) Do (
   (set Line="''%%a")
   (Set Line=!Line:^<=^^^<!) & (Set Line=!Line:^>=^^^>!)
   call:replace
   (echo\!Line!)>>"%pfad%new.txt"
)
@REM =======================================================================================
@REM Creation of the File with the new name in it
@REM =======================================================================================
type %pfad%new.txt|find /v "Name" > %pfad%%Username%_new_defaultprinter.txt
wmic printer where "Default = 'True'" get Name > %pfad%old.txt
@REM =======================================================================================
@REM Creation of the File with the old name in it
@REM =======================================================================================
type %pfad%old.txt|find /v "Name" > %pfad%%Username%_old_defaultprinter.txt
@REM =======================================================================================
@REM deletion of the temporary Files
@REM =======================================================================================
del %pfad%old_defaultprinter.txt
del %pfad%new.txt
del %pfad%old.txt
@REM =======================================================================================
@REM Replacing algorithm
@REM =======================================================================================
goto:eof ------------
:replace  subroutine
Set/a i = %i% + 1
(Set Line=!Line:''[%i%]=!)
Set "FindString2="
Set "FindString2=%FindString:<=^^^<%"
Set "FindString2=%FindString2:>=^^^>%"
Set "ReplaceWith2="
Set "ReplaceWith2=%ReplaceWith:<=^^^<%"
Set "ReplaceWith2=%ReplaceWith2:>=^^^>%"
(Set Line=!Line:%FindString2%=%ReplaceWith2%!)
(Set Line=%Line:~1,-1%)
goto:eof ------------
```

Skript Two:

Bash/shell

```
@echo off
@REM =======================================================================================
@REM Param to set the working path
@REM =======================================================================================
SET pfad="C:\Users\%Username%\Desktop\"
@REM =======================================================================================
@REM Param to read out the name of the new defaultprinter, which is stored in this file
@REM =======================================================================================
SET /p newDrucker=<%pfad%%USERNAME%_new_defaultprinter.txt
setlocal enabledelayedexpansion
@REM =======================================================================================
@REM search installed printing devices, if something is found with the wanted name, this one
@REM will be the new default printer.
@REM =======================================================================================
for /f "delims=" %%i in ('reg query "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Devices" ^| findstr "%newDrucker%"') do (
rundll32 printui.dll,PrintUIEntry /y /n "%newDrucker%"
)
```

