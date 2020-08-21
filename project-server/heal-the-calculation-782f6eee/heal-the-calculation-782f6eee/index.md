# Heal The Project Calculation Service timeout problems

## Original Links

- [x] Original Technet URL [Heal The Project Calculation Service timeout problems](https://gallery.technet.microsoft.com/Heal-The-Calculation-782f6eee)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Heal-The-Calculation-782f6eee/description)
- [x] Download: Not available.

## Output from Technet Gallery

One of the problems we encountered was timeout during an update of our projects from 2010 to 2016. Old cases need more time to be converted to the new format introduced in 2016.

The Project Calculation Service does have a default timeout of five minutes. This means for the really long running processes, the timeout may occur before the action such as saving the project is finished.  Here’s what you can do to both see the timeout setting and change it.

1.     Open the SharePoint 2016 Management Shell (open as an administrator).

2.     Type the following command:

Get-SPProjectPCSSettings -ServiceApplication “&lt;the name of your service application here&gt;”

The results will appear similar to this:

PS C:\temp&gt; Get-SPProjectPCSSettings -ServiceApplication "project application service"

MaximumIdleWorkersCount : 5

MaximumWorkersCount     : 200

EditingSessionTimeout   : 900000

MaximumSessionsPerUser  : 25

CachePersistence        : 604800000

MinimumMemoryRequired   : 250000000

RequestTimeLimits       : 300000

ResponseSizeLimits      : 214748364

MaximumProjectSize      : 2147483647

NetTcpPort              : 16001

The number that we’re interested in is the RequestTimeLimits. In this example, it’s set to 300,000 milliseconds which is 300 seconds or five minutes.

3.     To increase the limit, run:

Set-SPProjectPCSSettings -ServiceApplication “&lt;the name of your service application here&gt;” –RequestTimeLimits 600000

This will double the time limit. We still need to figure out the performance part, but this will prevent the random problems that are occurring because of the timeouts.

** **

