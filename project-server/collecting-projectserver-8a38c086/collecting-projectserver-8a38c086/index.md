# Collecting ProjectServer logs

## Original Links

- [x] Original Technet URL [Collecting ProjectServer logs](https://gallery.technet.microsoft.com/Collecting-ProjectServer-8a38c086)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Collecting-ProjectServer-8a38c086/description)
- [x] Download: Not available.

## Output from Technet Gallery

While debugging/testing features on ProjectServer you might need to examine logs. Here is a short step by step guid on how to get a clean log.

-- Draft

--select \*  from msp\_queue\_project\_message

delete from msp\_queue\_project\_message

delete from msp\_queue\_project\_group

delete from msp\_queue\_project\_group\_archive

delete from msp\_queue\_project\_filter

delete from msp\_queue\_project\_stats

1. Do a new job -  case save and/or publish

1. Take a uls verbose with SharePoint PowerShell as follows:

1-            $starttime = Get-Date

2-            Set-SPLogLevel -TraceSeverity VerboseEx

3-            New-SPLogFile

4-            Repro

5-            $endtime = Get-Date

6-            Merge-SPLogFile -Path MergedLog.log -StartTime $starttime -EndTime $endtime

7-            New-SPLogFile

8-            Clear-SPLogLevel

** **

