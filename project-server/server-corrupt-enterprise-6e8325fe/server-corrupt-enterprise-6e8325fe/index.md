# Project Server Corrupt Enterprise Resources / Cannot Publish a Resour

## Original Links

- [x] Original Technet URL [Project Server Corrupt Enterprise Resources / Cannot Publish a Resour](https://gallery.technet.microsoft.com/Server-Corrupt-Enterprise-6e8325fe)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Server-Corrupt-Enterprise-6e8325fe/description)
- [x] Download: Not available.

## Output from Technet Gallery

This is issue related to enterprise resources. If you select a resource in PWA and open it in Project Professional you cannot save these resources or publish. You will see a message "Internal Error" or similar for the resources.

Other symptoms

1. the problem resources do not have a callendar assigned if you query resources in the reporting database you will see it is missing

2. workhours in the  assignment by day table can differ from assignment table for the same task and single resourse

3. if you open a project with such a resource you get a message that says a resource is not an enterprise resource, and it will be coverted to local one. When you publish the project you get a message, a local resource does exist, would you like to confert  a local resource to enterprise one.

4. you can experience low project server performance by some project however I am not sure it is related to this issue for 100%

First you can diagnose the problem by running the first query on **PUBLISHED **database. If you see any rows, you have this problem.

SQL

```
SELECT RES_UID
from msp_resources R
left join MSP_CALENDARS C on R.RES_UID=C.CAL_UID
where C.CAL_UID is null
```

For unknown reason some resources can miss a calendar what leads to the described problem. The second query will insert the missing calendar records

SQL

```
SELECT RES_UID
, null
, (Select CAL_UID from msp_calendars where CAL_IS_STANDARD_CAL=1) as CAL_UID
,0,null,null,0,null,null,'2014-11-06 18:48:42.290','2014-11-06 18:48:42.290',2,9,2,9,1,1
from msp_resources R
left join MSP_CALENDARS C on R.RES_UID=C.CAL_UID
where C.CAL_UID is null
```

