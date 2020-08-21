# How to track task progress based on the change (mutation) moment.

## Original Links

- [x] Original Technet URL [How to track task progress based on the change (mutation) moment.](https://gallery.technet.microsoft.com/Track-task-dates-based-on-2dedfe7c)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Track-task-dates-based-on-2dedfe7c/description)
- [x] Download: Not available.

## Output from Technet Gallery

MS Project is one of the most advanced project planning systems. Nevertheless, consider this situation: a project manager asks you - how many tasks where completed today? you cannot answer this basis question out of the reporting database. Too crazy ? I know.

Any task in MS Project has start and end dates. These are planning dates. In our application we needed to report actual finish date as the moment when the task ready % is set on 100%. To our surprise Microsoft haven even though about it. It is not possible to get datetime of the moment a task is actually finished out of the reporting database. I know you might say , there two other fields - actual start date and actual finish date. Because the resource can put there whatever , we find it is not actual but reported. We just want to know when the resource pushed the button ready for all task without any further questions or interactions from the user. I can think of many applications where this is very valuable information.

For this purpose I designed a SQL server table and a query. You can  run this query at any frequency you need. I just made sure that it is fast and does not impact performance. It is in production on a very large project server installation with &gt; 1 million tasks per year.

In three staps we can implement this fantastic functionality.

##  Step 1

First of all, you need to create a table where you will keep task selection. In this example we like to keep TaskStartDate, TaskFinishDate, TaskPercentWorkComplete. In fact the dates you can extend by something like Submitted because they are different. The table can be created in Reporting database for project &lt;2013 or in reporting schema for projects &gt;2010.

SQL

```
CREATE TABLE [dbo].[EPM_TaskStat](
[TaskUID] [uniqueidentifier] NOT NULL,
[ResourceUID] [uniqueidentifier] NULL,
[TaskStartDate] [datetime] NULL,
[TaskFinishDate] [datetime] NULL,
[TaskPercentWorkCompleted] [smallint] NULL,
[CountStarted] [int] NULL,
[CountFinished] [int] NULL,
[DateCreated] [datetime] NULL,
 CONSTRAINT [PK_TaskStatus] PRIMARY KEY CLUSTERED
(
[TaskUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 70) ON [PRIMARY]
) ON [PRIMARY]
```

## Step 2

Second, we need a query that will insert and upate tasks.

SQL

```
MERGE [dbo].[EPM_TaskStat] AS T
USING [dbo].[EPM_TaskResourceView] AS S
ON (T.TaskUID = S.TaskUID)
WHEN NOT MATCHED BY TARGET AND S.[TaskPercentWorkCompleted]>0
    THEN INSERT([TaskUID], [TaskStartDate], [TaskFinishDate], [TaskPercentWorkCompleted],[CountStarted],[CountFinished],[ResourceUID]) VALUES(S.[TaskUID], getdate(),CASE WHEN S.TaskPercentWorkCompleted<100 then null else getdate() END,S.TaskPercentWorkCompleted,1,CASE WHEN S.TaskPercentWorkCompleted=100 then 1 else 0 END,S.ResourceUID)
WHEN MATCHED and T.TaskPercentWorkCompleted <> S.TaskPercentWorkCompleted
    THEN UPDATE SET T.TaskPercentWorkCompleted = S.TaskPercentWorkCompleted
    , T.TaskFinishDate = CASE WHEN T.TaskPercentWorkCompleted<100 and S.TaskPercentWorkCompleted=100 THEN getdate() ELSE null END
    , T.CountFinished=CASE WHEN S.TaskPercentWorkCompleted=100 and T.TaskPercentWorkCompleted<100 THEN 1 ELSE 0 END
    , T.TaskStartDate=CASE WHEN S.TaskPercentWorkCompleted=0 THEN '' END
    , T.CountStarted=CASE WHEN S.TaskPercentWorkCompleted=0 THEN 0 ELSE 1 END
    , T.ResourceUID=S.ResourceUID
;
```

Notice that we insert new tasks only if something happend to them e.g. TaskPercentWorkCompleted is not 0. In this case we insert actual date() into TaskStartDate. TaskFinishDate is updated based on the percentage value.

## Step 3

The last step is to schedule an agent job that will call the merge query and you are good to go!

Hope you like it, If you could rate the article it would be awesome.

