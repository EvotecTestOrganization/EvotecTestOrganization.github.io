# Publish Project Server Resource Plans

## Original Links

- [x] Original Technet URL [Publish Project Server Resource Plans](https://gallery.technet.microsoft.com/Publish-Server-Resource-6bea9da4)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Publish-Server-Resource-6bea9da4/description)
- [x] Download: [Download Link](Download\SOLVIN_ResPlan_EasyPublish.ps1)

## Output from Technet Gallery

```
.\SOLVIN_ResPlan_EasyPublish.ps1 [-ProjectServerURL] <String> [-DatabaseServer] <String> [-ReportingDB] <String> [[-WhereClause] <String>] [<CommonParameters>]
```

Publishes a specified list of project resource plans in Microsoft Project Server 2010 or 2013

The list of projects is queried from the Project Server (reporting) database by a query connecting to the standard MSP\_EPMProject\_UserView. It can be filtered by any column contained in this view.

After the list of Project UIDs is retrieved, the script will connect to the PSI Projects Webservice, checkout, publish and checkin the resource plans.

