# PowerShell Print Logger

## Original Links

- [x] Original Technet URL [PowerShell Print Logger](https://gallery.technet.microsoft.com/PowerShell-Print-Logger-09a6f4e0)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/PowerShell-Print-Logger-09a6f4e0/description)
- [x] Download: [Download Link](Download\PrintLogger.zip)

## Output from Technet Gallery

I've been logging print jobs for several years now. Early on we used the free PaperCut Print Logger, which was fine. It gave us the information we needed and worked very well for quite some time. A few years ago when we upgraded our print server to 2008,  we noticed some problems that we had not seen before. In an effort to reduce the number of variables we wound up uninstalling PaperCut. While it's very nice, it shims itself into the print stack, and while we can't say that was the problem, we can say that  we're not seeing any issues now.

So in order to continue monitoring jobs we needed to find a new solution. There wasn't one that worked for us, and met our key goal...FREE!

I wound up using some of the tech that is available in Windows 2008. The new Eventing system had been overhauled, and we now had the ability to create Event Triggers. If I hook a PowerShell script as an action, then I am nearly 80% of the way there. Early  on I was monitoring only Event ID 805, which worked well enough, and it wasn't until quite recently that I found I needed to also be looking at Event ID 307.

Event ID 805 contains nearly everything you would possibly need in logging a print job. It's one fatal flaw is that it doesn't also include the number of copies. Why that isn't in there I don't really know, but that information can in fact be found  in Event ID 307. Now that we know what to look at, we can move on.

The log that we are interested in is the Microsoft Windows PrintService Operational log. This log is disabled by default, even when you specify the File and Print server role to be installed. Once you've enabled that log you will need to create two Event  Triggers, or you can go the easy route and import the two XML files included in this download. These triggers have all the pertinent information required, in order for the two included scripts to work properly.

If you go the super easy route, the only other thing you need to do is create a database on your SQL server, assign a user account with insert permissions on the table you will create, and finally add the columns needed to contain the data. Here is a list  of the columns. I called my database Printing, and the table inside is named JobLog. I created a login called PrintLogger and it has insert permissions on the table.

| **Column Name** | **Data Type** |

| --- | --- |

| Time | Datetime |

| UserName | varchar(50) |

| Pages | int |

| DocumentName | ntext |

| Client | varchar(50) |

| Size | bigint |

| Printer | varchar(50) |

| Port | varchar(50) |

| Job | int |

| Copies | int |

In addition this script will also create a csv log file named for each day the script is run. It will automatically roll over to a filename at midnight each evening. I left this in as nice and handy backup, but can be easily removed.

One of the things I do is get a list of all the jobs that printed yesterday so I can see where we stand. The script below is called from my $Profile when I start up PowerShell each morning, and gives me a rather depressing view of what my users did yesterday.

```
if ((Get-Date).DayOfWeek -eq 'Monday')
{
    $DaysBack = 3
    }
else
{
    $DaysBack = 1
    }
$Yesterday = $null
$Yesterday = (Get-Date).AddDays(-$DaysBack)
$Query = "Declare @Today datetime;"
$Query += "select @Today = CAST(FLOOR(CAST(getdate() AS float)) AS DATETIME);"
$Query += "select * from dbo.joblog where (CAST(FLOOR(CAST(Time AS float)) AS DATETIME)) = (dateadd(day,-$($DaysBack),@Today));"
$Table = C:\scripts\powershell\playground\Get-SQlData.ps1 -SqlUser $UserName -SqlPass $Password -SqlServer $ServerName -SqlDatabase $DB -SqlTable $Table -Query $Query
$Dbnull = [System.DBNull]::Value
$MaxRow = $null
$UserCount = $null
$TotalPages = $null
$MaxRow = ($Table |Sort-Object -Property Pages -Descending)[0]
$UserCount = ($Table |Sort-Object -Property Username -Unique).Count
foreach ($Row in $Table)
{
    if ($Row.Copies -eq $Dbnull)
    {
        [int]$Copies = 1
        }
    else
    {
        [int]$Copies = $Row.Copies
        }
    if ($Row.Pages -eq 0)
    {
        [int]$Pages = 1
        }
    else
    {
        [int]$Pages = $Row.Pages
        }
    $Total = $Pages * $Copies
    $TotalPages += $Total
    }
$Report = New-Object -TypeName PSObject -Property @{
    DateSubmitted = $Yesterday.ToShortDateString()
    PrintJobs = $Table.Count
    PagesPrinted = $TotalPages
    ReamsUsed = $TotalPages/500
    BoxesUsed = $TotalPages/500/10
    UsersPrinting = $UserCount
    MaxJob = $MaxRow.Pages
    }
$Report |Select-Object -Property DateSubmitted, PrintJobs, PagesPrinted, UsersPrinting, MaxJob, ReamsUsed, BoxesUsed
```

