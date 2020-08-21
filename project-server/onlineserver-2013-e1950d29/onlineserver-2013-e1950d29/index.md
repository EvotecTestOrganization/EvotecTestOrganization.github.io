# Project Online/Server 2013: Timephased Work Management with CSOM - Starter Ki

## Original Links

- [x] Original Technet URL [Project Online/Server 2013: Timephased Work Management with CSOM - Starter Ki](https://gallery.technet.microsoft.com/OnlineServer-2013-e1950d29)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/OnlineServer-2013-e1950d29/description)
- [x] Download: [Download Link](Download\Neos-SDI Project Online Starter Kit.zip)

## Output from Technet Gallery

This project illustrates how to use Project Server 2013 CSOM for:

- Reading Project and Tasks

- Adding Tasks, and Timephased Assignment

- Adding Timephased Actual on Assignment

 ![](Images\capture-timesheet.png)

It's a simple console application, and work on Project Online, as well as Project On Prem. All methods are commented, specially where things seems not obvious.

 ![](Images\capture-console.png)

This project is intented to be a helper for your development, because the Project Server 2013 SDK is not fully documented. On the Support Forum in Technet, a lot of questions are often asked, related to this area of development. So I hope that this project will save (a bit of) your time.

The pre requisite are:

- Having a Project Server 2013 instance on line or On Premise

- Having at list One project

- The periods must be created, and the Timesheet for the current period must be created (simply click on the TimeSheet link on PWA). This issue will be solved soon.

- The current user must be defined as a resource

- On your development machine, VS2013, Project Server 2013 SDK, and the SharePoint Server 2013 Client Components SDK.

Normally, all dependencies are included in the Libraries folder.

Some of these assemblies must be in GAC If you need more info, contact me:

mail: mailto://sylvain.gross@neos-sdi.com

twitter: @SylvainGrossNeo

If you have some suggestions, or improvement proposal, don't hesitate to contact me. This app may contain some bugs or "undiscovered behaviour" ;-), it's not intended to be used as is in Production.

Your feedback are welcome to improve this code. You can also contact me if you have difficulties to create a Project Online tenant, or Project Server environment.

C#

```
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.ProjectServer.Client;
using Microsoft.SharePoint.Client;
//using NeosSDI.ProjectOnline.Business;
namespace NeosSDI.ProjectOnline.CSOM
{
    public class ProjectCSOMManager
    {
        // Change this value if you are on prem and not Online
        private static  bool IsProjectOnline = true;
        private static int timeOut = 20;
        private static string projName = "yourtenant"; // define the name of your tenant here
        private static string connectUserName = "administrator"; // user name with the domaine
        private static string connectPwd = "YOUR PWD"; // your pwd
        private static string projDomain = string.Format("{0}.onmicrosoft.com", projName);
        // Set the Project Server client context.
        private static ProjectContext projContext;
        private static string PwaPath
        {
            get
            {
                // Change here the name of the PWA instance: PWA should be the must common case.
                if (IsProjectOnline)
                    return string.Format("https://{0}.sharepoint.com/sites/pwa", projName);
                else
                    return "http://2013-sp/pwa";
            }
        }
        /// <summary>
        /// This method performs a very simple operation: Read Projects, and the Tasks of these projets
        /// Result is stored in the ProjectContext, and returned to the client.
        /// Step by step, we have to:
        /// - Manage authentification, for Project Online, or Project On Prem
        /// - Create the Query, to ask for the projects, and to include some additionnal properties (dates, tasks...)
        /// - Execute the Query
        /// </summary>
        /// <returns></returns>
        public static ProjectContext ReadProjects()
        {
            try
            {
                projContext = new ProjectContext(PwaPath);
                if (IsProjectOnline)
                    projContext.ExecutingWebRequest += ClaimsHelper.clientContext_ExecutingWebRequest;
                else
                    projContext.Credentials = new System.Net.NetworkCredential("alexd", "pass@word1", "contoso");
                // Use IncludeWithDefaultProperties to force CSOM to load the Tasks collection, otherwize we have a (very) lazy loading
                // Careful: the Load method does not perform the Load ! It prepare the context before the ExecuteQuery is run.
                projContext.Load(projContext.Projects,
                    c => c.IncludeWithDefaultProperties(pr => pr.StartDate, pr => pr.FinishDate, pr => pr.Tasks));
                // Actual execution of the Load - AFter this method, the Projects collection contains data, and the properties which are specified below.
                projContext.ExecuteQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return projContext;
        }
        /// <summary>
        /// This method add a task to the project, and assign, me to it.
        /// The date of assignment is hardcoded to today
        ///
        /// The steps:
        /// - Manage authentification, for Project Online, or Project On Prem
        /// - Prepare the Queries to load Projects and the Web Context (to get the current user)
        /// - Execute this first queries
        /// - Prepare the Query to load the Resource linked to the current user
        /// - Load the First existing Project, and check it out, to get its Draft version
        /// - Create the Task with the TaskCreationInformation class
        /// - Add it to the Project
        /// - Update the Project, and execute this long query
        /// - Create an assignment for this task, and the current resource, with the AssignmentCreationInformation class
        /// - Add it to the Project
        /// - Update the Project, and execute this query
        /// - Publish/Checkin the project
        /// </summary>
        public static void AddTasksToProject()
        {
            try
            {
                projContext = new ProjectContext(PwaPath);
                if (IsProjectOnline)
                    projContext.ExecutingWebRequest += ClaimsHelper.clientContext_ExecutingWebRequest;
                else
                    projContext.Credentials = new System.Net.NetworkCredential("alexd", "pass@word1", "contoso");
                // Use IncludeWithDefaultProperties to force CSOM to load the Tasks collection, otherwize we have a lazy loading
                // Careful: the Load method does not perform the Load ! It prepare the context before the ExecuteQuery is run.
                projContext.Load(projContext.Projects,
                    c => c.IncludeWithDefaultProperties(pr => pr.StartDate, pr => pr.FinishDate, pr => pr.Tasks));
                projContext.Load(projContext.Web.CurrentUser);
                projContext.ExecuteQuery();
                string currentUserName = projContext.Web.CurrentUser.LoginName;
                // Important to exclude resource without associated user (a resource who does not have an account)
                projContext.Load(projContext.EnterpriseResources,
                        res => res.IncludeWithDefaultProperties(r => r.User, r => r.User.LoginName).Where(r => r.User != null && r.User.LoginName == currentUserName));
                // Actual execution of the Load - After this method, the Projects collection contains data, and the properties which are specified below.
                projContext.ExecuteQuery();
                var pubProject = projContext.Projects.FirstOrDefault();
                var currentProject = pubProject.CheckOut();
                if (currentProject == null)
                    throw new Exception("Please create a project !");
                var currentResource = projContext.EnterpriseResources.FirstOrDefault();
                if (currentResource == null)
                    throw new Exception("Please create yourself as a resource !");
                TaskCreationInformation tsk = new TaskCreationInformation();
                tsk.Name = string.Format("Task created at {0}", DateTime.Now);
                tsk.Start = DateTime.Now;
                tsk.Finish = DateTime.Now.AddDays(3);
                var newTask = currentProject.Tasks.Add(tsk);
                projContext.Load(newTask);
                QueueJob qj = currentProject.Update();
                JobState js = projContext.WaitForQueue(qj, timeOut);
                projContext.ExecuteQuery();
                AssignmentCreationInformation ass = new AssignmentCreationInformation();
                ass.ResourceId = currentResource.Id;
                ass.TaskId = newTask.Id;
                ass.Start = newTask.Start;
                ass.Finish = newTask.Finish;
                currentProject.Assignments.Add(ass);
                currentProject.Update();
                qj= currentProject.Publish(true);
                js = projContext.WaitForQueue(qj, timeOut);
                projContext.ExecuteQuery();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine(ex.Message);
                throw ex;
            }
        }
        /// <summary>
        /// This method add actuals to an existing assignment, by using TimeSheets.
        /// Pre requisite: periods must be created
        /// Current bug: the timehseet must exist for this period (simply clic on TimeSheet link in PWA once for the current period
        /// Steps are:
        /// - Manage authentification, for Project Online, or Project On Prem
        /// - Prepare the Query to load the Web Context (to get the current user)
        /// - Execute this first query
        /// - Prepare the Query to load the Resource linked to the current user
        /// - Prepare the Query to load the current period, by including, TimeSheet, which includes Lines, which include Work and Assignments. The lines are filtered in order to include only Standard Lines, and not admin lines (sick, vacation...)
        /// - Execute this Query
        /// - For the current line, retrieve the planned work for today
        /// - Create the TimesheetWork with the TimeSheetWorkCreationInformation class, and set the different properties
        /// - Add this work to the line, and Update the TimeSheet
        /// - Submit the TimeSheet, after management of the current status of the TimeSheet
        /// </summary>
        public static void AddActualToTaskTimeSheet()
        {
            try
            {
                projContext = new ProjectContext(PwaPath);
                if (IsProjectOnline)
                    projContext.ExecutingWebRequest += ClaimsHelper.clientContext_ExecutingWebRequest;
                else
                    projContext.Credentials = new System.Net.NetworkCredential("alexd", "pass@word1", "contoso");
                projContext.Load(projContext.Web.CurrentUser);
                projContext.ExecuteQuery();
                string currentUserName = projContext.Web.CurrentUser.LoginName;
                // Important to exclude resource without associated user (a resource who does not have an account)
                projContext.Load(projContext.EnterpriseResources,
                        res => res.IncludeWithDefaultProperties(r => r.User, r => r.User.LoginName).Where(r => r.User != null && r.User.LoginName == currentUserName));
                // Actual execution of the Load - After this method, the Projects collection contains data, and the properties which are specified below.
                projContext.ExecuteQuery();
                var currentResource = projContext.EnterpriseResources.FirstOrDefault();
                if (currentResource == null)
                    throw new Exception("Please create yourself as a resource !");
                projContext.Load(projContext.TimeSheetPeriods, c => c.Where(p => p.Start <= DateTime.Now && p.End >= DateTime.Now).
                    IncludeWithDefaultProperties(p => p.TimeSheet,
                                                 p => p.TimeSheet.Lines.Where(l => l.LineClass== TimeSheetLineClass.StandardLine).
                    IncludeWithDefaultProperties(l => l.Assignment,
                                                       l => l.Assignment.Task,
                                                       l => l.Work)));
                projContext.ExecuteQuery();
                var myPeriod = projContext.TimeSheetPeriods.FirstOrDefault();
                if (myPeriod == null)
                    throw new Exception("Please create the periods in your server settings");
                var line = myPeriod.TimeSheet.Lines.Last();// FirstOrDefault();
                var plannedwork = line.Work.Where(w => w.Start.Date == DateTime.Now.Date).FirstOrDefault();
                TimeSheetWorkCreationInformation workCreation = new TimeSheetWorkCreationInformation
                {
                    ActualWork = string.Format("{0}h", 6),
                    Start = DateTime.Now,
                    End = DateTime.Now,
                    Comment = "From CSOM",
                    NonBillableOvertimeWork = "0",
                    NonBillableWork = "0",
                    OvertimeWork = "0",
                    PlannedWork = plannedwork == null ? "0h" : plannedwork.PlannedWork
                };
                line.Work.Add(workCreation);
                myPeriod.TimeSheet.Update();
                if (myPeriod.TimeSheet.Status == TimeSheetStatus.Approved ||
                    myPeriod.TimeSheet.Status == TimeSheetStatus.Submitted ||
                    myPeriod.TimeSheet.Status == TimeSheetStatus.Rejected)
                {
                    myPeriod.TimeSheet.Recall();
                }
                myPeriod.TimeSheet.Submit("GO");
                projContext.ExecuteQuery();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Trace.WriteLine(ex.Message);
                throw ex;
            }
        }
        #region Helper Methods
        /// <summary>
        /// This properties manages Authentification for Project Online, through the well known Helper.Office365.Claims assembly
        /// </summary>
        private static Helper.Office365.MsOnlineClaimsHelper ClaimsHelper
        {
            get
            {
                return new Helper.Office365.MsOnlineClaimsHelper(new Uri(PwaPath),
                                                    string.Format("{0}@{1}", connectUserName, projDomain),
                                                    connectPwd);
            }
        }
        private static string GetFullUserName(string userName)
        {
            return string.Format("i:0#.f|membership|{0}@{1}", userName, projDomain);
        }
        #endregion
    }
}
```

