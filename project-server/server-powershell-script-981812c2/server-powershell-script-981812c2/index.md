# Project Server: PowerShell script to force a checkin of all checkedout projects

## Original Links

- [x] Original Technet URL [Project Server: PowerShell script to force a checkin of all checkedout projects](https://gallery.technet.microsoft.com/Server-PowerShell-script-981812c2)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-PowerShell-script-981812c2/description)
- [x] Download: [Download Link](Download\SOLVIN_EasyCheckIn.ps1)

## Output from Technet Gallery

```
.\SOLVIN_EasyCheckin.ps1 -ProjectServerURL  http://projectserver/pwa -DatabaseServer SQLSRV1 -DraftDB PWA_Draft
```

The attached script reads all checkedout projects from the draft database and sends checkin requests to the specified Project Server instance.

Example:

.\SOLVIN\_EasyCheckin.ps1 -ProjectServerURL http://projectserver/pwa -DatabaseServer SQLSRV1 -DraftDB PWA\_Draft

If you want to use it with Project Server 2013, you only need to change this SQL query inside the script

 SELECT [Proj\_UID] FROM [dbo].[MSP\_projects] WHERE proj\_checkoutby is not null and proj\_type in (0,5,6)

 to

 SELECT [Proj\_UID] FROM [draft].[MSP\_projects] WHERE proj\_checkoutby is not null and proj\_type in (0,5,6)

 and run the job using the Project Server 2013 databaase for the -DraftDB parameter.

Christoph Mülder

 Project Management Consultant, MCSE, MCT

 SOLVIN information management GmbH

