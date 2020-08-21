###############################################################################################
# purgeoeminf.ps1
# 
# AUTHOR: Amaury Greiner, Microsoft
#
# THIS CODE-SAMPLE IS PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED 
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR 
# FITNESS FOR A PARTICULAR PURPOSE.
#
# This sample is not supported under any Microsoft standard support program or service. 
# The script is provided AS IS without warranty of any kind. Microsoft further disclaims all
# implied warranties including, without limitation, any implied warranties of merchantability
# or of fitness for a particular purpose. The entire risk arising out of the use or performance
# of the sample and documentation remains with you. In no event shall Microsoft, its authors,
# or anyone else involved in the creation, production, or delivery of the script be liable for 
# any damages whatsoever (including, without limitation, damages for loss of business profits, 
# business interruption, loss of business information, or other pecuniary loss) arising out of 
# the use of or inability to use the sample or documentation, even if Microsoft has been advised 
# of the possibility of such damages.
###############################################################################################
#SOF
#initilizing variables
$oeminfmatches = $null;
$oeminfselection = $null;
$infdir = $env:windir+"\inf";

#create folder for logging/troubleshooting data
$logdir = "C:\Install\purgeoeminf";
$logfile = "purgeoeminf.log"
$logfullpath = $logdir+"\"+$logfile;

New-Item $logdir -ItemType Directory -force;

#start recording, doesn't work if run remotely
Start-Transcript -Path $logfullpath -force;

#search for oem*.inf files
$oeminflist = gci $infdir\*.* -Include oem*.inf;

#copy some logs
Copy-Item $infdir\setupapi.app.log $logdir -force;
wevtutil epl Microsoft-Windows-PrintService/Admin $logdir\PrintServiceAdmin.evtx /ow:true;

#searchpattern
$infname = "hpcu118u";

#searching in $oeminflist and putting matches in $oeminfmatches; backing up matches in $logdir
foreach ($inf in $oeminflist) {
        Select-String -path $inf.FullName -Pattern $infname -List| foreach {
            $oeminfmatches += $_.filename;
            copy-item $_.path $logdir -force;
            write-host " Found $infname in"$_.path ;
            }
        }

#start uninstalling infs
if ($oeminfmatches -ne $null){
    foreach ($match in $oeminfmatches) {
        pnputil -f -d $match
        }
    Restart-Service Spooler;
    }
else {
    write-host "No inf-files found matching pattern: $infname";
    }

#let user choose which inf to delete
#$oeminfselection = $oeminfmatches | Out-GridView -PassThru -title "Select inf to uninstall:";
#
#delete inf only if inf was selected for deletion
#
#if ($oeminfselection -ne $null -and $oeminfmatches -ne $null) {
#    pnputil -f -d $oeminfselection
#    }
#else {
#    write-host " No selection made or no inf-files found which match pattern $infname ";
#    }

#stop recording
Stop-Transcript;
#EOF