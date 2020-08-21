<# 
 
.SYNOPSIS 
Register an eventhandler in Microsoft Project Server 2010/2013 
 
.DESCRIPTION 
Register an eventhandler in Microsoft Project Server 2010/2013 
 
.PARAMETER PwaUrl     
URL of the Project Server instance to be connected to (example: http://projectserver/pwa 

.PARAMETER Name     
Friendly name of your Project Server event handler

.PARAMETER Description 
A short explanation of what your event handler does.
 
.PARAMETER AssemblyName 
Provide the full name of the strongly named event handler assembly. For example: mydll, Version=1.1.0.0, Culture=neutral, PublicKeyToken=xxxxxxxxxxxxxxxx.
Example: "ProjectServerEventReceiver, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2affc510165cbe13"
 
.PARAMETER ClassName 
Provide the fully qualified name of the class that implements the event handler functionality.
Example: "ProjectServerEventReceiver.PSEventReceiver"

.PARAMETER EventId     
Provide the id of the event you would like to hook your event on. You can use the enum as demonstrated below.
Example: [WebServiceProxy.PSEventID]::ProjectPublished

.PARAMETER Order     
Provide the order for the event handler. 
If there are multiple event handlers associated with this event, the order number will determine the sequence in which the event handlers will be be executed. 

.PARAMETER EndpointUrl     
Optionally, only 2013. 
Provide the WCF Endpoint URL. 
For example: http://www.example.com/RemoteEventService.svc.

.EXAMPLE 
.\Register-PSEventHandler.ps1 -PwaUrl "http://<server>/<pwa>" -Name "Friendly name of your Project Server event handler" -Description "A short explanation of what your event handler does." -AssemblyName "ProjectServerEventReceiver, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2affc510165cbe13" -ClassName "ProjectServerEventReceiver.PSEventReceiver" -EventId ([int32][WebServiceProxy.PSEventID]::ProjectPublished) -Order 1

.EXAMPLE 
.\Register-PSEventHandler.ps1 -PwaUrl "http://<server>/<pwa>" -Name "Friendly name of your Project Server event handler" -Description "A short explanation of what your event handler does." -AssemblyName "ProjectServerEventReceiver, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2affc510165cbe13" -ClassName "ProjectServerEventReceiver.PSEventReceiver" -EventId 53 -Order 1 

.NOTES 
You need to have administrative permissions in Project Server to run this Script. 

Enum of EventIds
0 : AdminReportingPeriodUpdated
1 : AdminReportingPeriodUpdating
2 : AdminLineClassUpdated
3 : AdminLineClassUpdating
4 : AdminStatusReportsDeleted
5 : AdminStatusReportsDeleting
6 : WssInteropWssWorkspaceCreated
7 : WssInteropWssWorkspaceCreating
8 : Deprecated8
9 : Deprecated9
10 : AdminAdSyncERPSynchronized
11 : AdminAdSyncERPSynchronizing
12 : AdminAdSyncGroupSynchronized
13 : AdminAdSyncGroupSynchronizing
14 : AdminAdSyncGroupsSynchronized
15 : AdminAdSyncGroupsSynchronizing
16 : CalendarCreated
17 : CalendarCreating
18 : CalendarDeleted
19 : CalendarDeleting
20 : CalendarChanged
21 : CalendarChanging
22 : CalendarCheckedOut
23 : CalendarCheckingOut
24 : CalendarCheckedIn
25 : CalendarCheckingIn
26 : CustomFieldsCreated
27 : CustomFieldsCreating
28 : CustomFieldsDeleted
29 : CustomFieldsDeleting
30 : CustomFieldsUpdated
31 : CustomFieldsUpdating
32 : CustomFieldsCheckedOut
33 : CustomFieldsCheckingOut
34 : CustomFieldsCheckedIn
35 : CustomFieldsCheckingIn
36 : LookupTableCreated
37 : LookupTableCreating
38 : LookupTableDeleted
39 : LookupTableDeleting
40 : LookupTableUpdated
41 : LookupTableUpdating
42 : LookupTableCheckedOut
43 : LookupTableCheckingOut
44 : LookupTableCheckedIn
45 : LookupTableCheckingIn
46 : ProjectCreated
47 : ProjectCreating
48 : ProjectDeleted
49 : ProjectDeleting
50 : ProjectSaved
51 : ProjectCheckIn
52 : ProjectSaveFailed
53 : ProjectPublished
54 : ProjectPublishing
55 : ProjectWssWorkspaceAddressUpdated
56 : ProjectWssWorkspaceAddressUpdating
57 : ProjectWssWorkspaceAddressDeleted
58 : ProjectWssWorkspaceAddressDeleting
59 : ProjectActivityUpgraded
60 : ProjectActivityUpgrading
61 : ReportingResourceCapacitiesChanged
62 : ReportingCustomFieldCreated
63 : ReportingCustomFieldChanged
64 : ReportingCustomFieldDeleted
65 : ReportingUserViewChanged
66 : ReportingFiscalPeriodChanged
67 : ReportingFiscalPeriodDeleted
68 : ReportingLookupTableCreated
69 : ReportingLookupTableChanged
70 : ReportingLookupTableDeleted
71 : ReportingProjectCreated
72 : ReportingProjectChanged
73 : ReportingProjectDeleted
74 : ReportingResourceCapacityTimeRangeChanged
75 : ReportingResourceCreated
76 : ReportingResourceChanged
77 : ReportingResourceDeleted
78 : ReportingTimesheetSaved
79 : ReportingTimesheetAdjusted
80 : ReportingTimesheetDeleted
81 : ReportingTimesheetClassChanged
82 : ReportingTimesheetPeriodCreated
83 : ReportingTimesheetPeriodChanged
84 : ReportingTimesheetPeriodDeleted
85 : ReportingTimesheetStatusChanged
86 : ReportingProjectWorkspaceCreated
87 : ReportingProjectWorkspaceChanged
88 : ReportingProjectWorkspaceDeleted
89 : ResourceCreated
90 : ResourceCreating
91 : ResourceDeleted
92 : ResourceDeleting
93 : ResourceDeactivated
94 : ResourceDeactivating
95 : ResourceChanged
96 : ResourceChanging
97 : ResourceActivated
98 : ResourceActivating
99 : ResourceCheckedOut
100 : ResourceCheckingOut
101 : ResourceCheckedIn
102 : ResourceCheckingIn
103 : ResourceSetAuthorization
104 : ResourceSettingAuthorization
105 : SecurityOrganizationalPermissionsUpdated
106 : SecurityOrganizationalPermissionsUpdating
107 : SecurityGroupDeleted
108 : SecurityGroupDeleting
109 : SecurityGroupCreated
110 : SecurityGroupCreating
111 : SecurityGroupUpdated
112 : SecurityGroupUpdating
113 : SecurityCategoryDeleted
114 : SecurityCategoryDeleting
115 : SecurityCategoryCreated
116 : SecurityCategoryCreating
117 : SecurityCategoryUpdated
118 : SecurityCategoryUpdating
119 : SecurityTemplateCreated
120 : SecurityTemplateCreating
121 : SecurityTemplateUpdated
122 : SecurityTemplateUpdating
123 : SecurityTemplateDeleted
124 : SecurityTemplateDeleting
125 : StatusReportsRequestCreated
126 : StatusReportsRequestCreating
127 : StatusReportsRequestUpdated
128 : StatusReportsRequestUpdating
129 : StatusReportsResponseCreated
130 : StatusReportsResponseCreating
131 : StatusReportsResponseUpdated
132 : StatusReportsResponseUpdating
133 : StatusingApplied
134 : StatusingApplying
135 : StatusingHistoryDeleted
136 : StatusingHistoryDeleting
137 : StatusingStatusUpdated
138 : StatusingStatusUpdating
139 : StatusingStatusSubmitted
140 : StatusingStatusSubmiting
141 : StatusingAssignmentDeleted
142 : StatusingAssignmentDeleting
143 : StatusingAssignmentDelegated
144 : StatusingAssignmentDelegating
145 : StatusingTaskCreated
146 : StatusingTaskCreating
147 : StatusingAssignmentWorkDataSet
148 : StatusingAssignmentWorkDataSetting
149 : StatusingApprovalsUpdated
150 : StatusingApprovalsUpdating
151 : NotificationsSent
152 : NotificationsSending
153 : RulesCreated
154 : RulesCreating
155 : RulesDeleted
156 : RulesDeleting
157 : RulesCopied
158 : RulesCopying
159 : RulesProcessed
160 : RulesProcessing
161 : TimesheetCreated
162 : TimesheetCreating
163 : TimesheetDeleted
164 : TimesheetDeleting
165 : TimesheetUpdated
166 : TimesheetUpdating
167 : TimesheetSubmitted
168 : TimesheetSubmitting
169 : TimesheetRecalled
170 : TimesheetRecalling
171 : TimesheetReviewed
172 : TimesheetReviewing
173 : TimesheetLineApproved
174 : TimesheetLineApproving
175 : CubeAdminCubeBuilt
176 : CubeAdminCubeBuilding
177 : ProjectUpdated
178 : ProjectUpdating
179 : ProjectAdded
180 : ProjectAdding
181 : ProjectEntitiesDeleted
182 : ProjectEntitiesDeleting
183 : CubeAdminCubeProcessed
184 : SecurityProjectCategoryCreated
185 : SecurityProjectCategoryCreating
186 : SecurityProjectCategoryUpdated
187 : SecurityProjectCategoryUpdating
188 : SecurityProjectCategoryDeleted
189 : SecurityProjectCategoryDeleting
190 : ProjectUpdatedScheduledProject
191 : ProjectUpdatingScheduledProject
192 : OptimizerPlannerSolutionCommitted
193 : OptimizerOptimizerSolutionCommitted
194 : ReportingTimesheetProjectAggregated
195 : WorkflowRunning
196 : UserDelegationActivated
197 : UserDelegationActivating
198 : UserDelegationChanged
199 : UserDelegationChanging
200 : UserDelegationDeactivated
201 : UserDelegationDeactivating
202 : UserDelegationCreated
203 : UserDelegationCreating
204 : UserDelegationDeleted
205 : UserDelegationDeleting
206 : ProjectSummaryPublished
207 : ProjectSummaryPublishing
208 : ReportingWorkflowPhaseUpdated
209 : ReportingWorkflowPhaseDeleted
210 : ReportingWorkflowStageUpdated
211 : ReportingWorkflowStageDeleted
212 : ReportingEnterpriseProjectTypeUpdated
213 : ReportingEnterpriseProjectTypeDeleted
214 : ReportingProjectWorkflowInformationChanged
215 : ReportingProjectSummaryChanged
216 : ReportingCommittedSolutionDecisionChanged
217 : WorkflowProjectTypeChanging
218 : WorkflowProjectTypeChanged
219 : WorkflowStageEntered
220 : WorkflowStarted
221 : WorkflowCompleted
222 : ResourcePlanResourcePlanPublished
223 : ResourcePlanResourcePlanPublishing
224 : ProjectSyncedProjectEnterpriseEntities
225 : ProjectSyncingProjectEnterpriseEntities
226 : ProjectUpdatedPwaProject
227 : ProjectUpdatingPwaProject

#> 

#define parameters 
PARAM( 
    [parameter(Mandatory=$true)] 
    [string]
    $PwaUrl,  
    
    [parameter(Mandatory=$true)] 
    [string]  
    $Name,
    
    [parameter(Mandatory=$true)] 
    [string]  
    $Description, 

    [string] 
    [parameter(Mandatory=$true)] 
    $AssemblyName, 
	
    [string] 
    [parameter(Mandatory=$true)] 
    $ClassName, 
	
    [string] 
    [parameter(Mandatory=$true)] 
    $EventId, 
	
    [int32] 
    [parameter(Mandatory=$false)] 
    $Order = 1, 
	
    [string] 
    [parameter(Mandatory=$false)] 
    $EndpointUrl	
) 

Write-Host "Load Event Handlers webservice... " -f Green
$svcPSEvents = New-WebServiceProxy -uri "$PwaUrl/_vti_bin/psi/events.asmx?wsdl" -Namespace WebServiceProxy -Class PSEvents -useDefaultCredential
Write-Host "Register the Event Handler in Project Server." -f Green
$ehDS = New-Object  WebServiceProxy.EventHandlersDataSet
$ehRow = $ehDS.EventHandlers.NewEventHandlersRow()

# Provide a friendly name and description for the event handler
$ehRow.Name = $Name
$ehRow.Description = $Description
# Provide the full name of the strongly named event handler assembly. For example: mydll, Version=1.1.0.0, Culture=neutral, PublicKeyToken=xxxxxxxxxxxxxxxx.
$ehRow.AssemblyName = $AssemblyName 
# Provide the fully qualified name of the class that implements the event handler functionality.
$ehRow.ClassName = $ClassName
# Provide the id of the event you would like to hook your event on. You can use the enum as demonstrated below.
$ehRow.EventId = $EventId
# Provide the order for the event handler. If there are multiple event handlers associated with this event, the order number will determine the sequence in which the event handlers will be be executed. 
$ehRow.Order = $Order; 
# Optionally, only 2013. Provide the WCF Endpoint URL. For example: http://www.example.com/RemoteEventService.svc.
$ehRow.EndpointUrl = $EndpointUrl
$ehRow.EventHandlerUid = [System.Guid]::NewGuid()

$ehDS.EventHandlers.AddEventHandlersRow($ehRow)
$svcPSEvents.CreateEventHandlerAssociations($ehDS)
Write-Host "Done. It will take a minute to become visible in the server settings page of Project Server." -f Green


