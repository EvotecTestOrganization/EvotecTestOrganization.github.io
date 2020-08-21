# Register custom Event Handlers in Project Server 2010/2013 (on premise)

## Original Links

- [x] Original Technet URL [Register custom Event Handlers in Project Server 2010/2013 (on premise)](https://gallery.technet.microsoft.com/Register-custom-Event-7c85c962)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Register-custom-Event-7c85c962/description)
- [x] Download: [Download Link](Download\Register-PSEventHandler.ps1)

## Output from Technet Gallery

If you have a many event handlers or a lot of servers (dev, int, test, acc, ... , prod) or the person who has to deploy your custom event handlers is less experienced. It can be interesting to have a little script to do this enoying work for you.

The powershell snippet below registers an event handler for Project Server. You have to fill in a few parameters.

**Specific to each deployment:**

 - PwaUrl: The URL of the PWA instance that you target. (eg: "http://project.contoso.com/pwa")

**Specific to your event handler. Fill it in once.**

 - Name: Friendly name.

 - Description: Friendly description.

 - AssemblyName: For example: mydll, Version=1.1.0.0, Culture=neutral, PublicKeyToken=xxxxxxxxxxxxxxxx.

 - ClassName: fully qualified name of the class that implements the event handler functionality.

 - EventId: Use the enum to find the id of the event you need. [WebServiceProxy.PSEventID]::ProjectPublished

 - Order: The order number will determine the sequence in which the event handlers will be be executed. Default: 1.

```
<#
.SYNOPSIS
Register an eventhandler in Microsoft Project Server 2010/2013
.DESCRIPTION
Register an eventhandler in Microsoft Project Server 2010/2013
.PARAMETER PwaUrl
URL of the Project Server instance to be connected to (example: http://projectserver/pwa
.PARAMETER Name
Friendly name of your Project Server event handler
.PARAMETER Description
A short explanation of what your event handler does.
.PARAMETER AssemblyName
Provide the full name of the strongly named event handler assembly. For example: mydll, Version=1.1.0.0, Culture=neutral, PublicKeyToken=xxxxxxxxxxxxxxxx.
Example: "ProjectServerEventReceiver, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2affc510165cbe13"
.PARAMETER ClassName
Provide the fully qualified name of the class that implements the event handler functionality.
Example: "ProjectServerEventReceiver.PSEventReceiver"
.PARAMETER EventId
Provide the id of the event you would like to hook your event on. You can use the enum as demonstrated below.
Example: [WebServiceProxy.PSEventID]::ProjectPublished
.PARAMETER Order
Provide the order for the event handler.
If there are multiple event handlers associated with this event, the order number will determine the sequence in which the event handlers will be be executed.
.PARAMETER EndpointUrl
Optionally, only 2013.
Provide the WCF Endpoint URL.
For example: http://www.example.com/RemoteEventService.svc.
.EXAMPLE
.\Register-PSEventHandler.ps1 -PwaUrl "http://<server>/<pwa>" -Name "Friendly name of your Project Server event handler" -Description "A short explanation of what your event handler does." -AssemblyName "ProjectServerEventReceiver, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2affc510165cbe13" -ClassName "ProjectServerEventReceiver.PSEventReceiver" -EventId ([int32][WebServiceProxy.PSEventID]::ProjectPublished) -Order 1
.EXAMPLE
.\Register-PSEventHandler.ps1 -PwaUrl "http://<server>/<pwa>" -Name "Friendly name of your Project Server event handler" -Description "A short explanation of what your event handler does." -AssemblyName "ProjectServerEventReceiver, Version=1.0.0.0, Culture=neutral, PublicKeyToken=2affc510165cbe13" -ClassName "ProjectServerEventReceiver.PSEventReceiver" -EventId 53 -Order 1
.NOTES
You need to have administrative permissions in Project Server to run this Script.
Enum of EventIds
0 : AdminReportingPeriodUpdated
1 : AdminReportingPeriodUpdating
2 : AdminLineClassUpdated
...
225 : ProjectSyncingProjectEnterpriseEntities
226 : ProjectUpdatedPwaProject
227 : ProjectUpdatingPwaProject
#>
#define parameters
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
    $Order = 1,
    [string]
    [parameter(Mandatory=$false)]
    $EndpointUrl
)
Write-Host "Load Event Handlers webservice... " -f Green
$svcPSEvents = New-WebServiceProxy -uri "$PwaUrl/_vti_bin/psi/events.asmx?wsdl" -Namespace WebServiceProxy -Class PSEvents -useDefaultCredential
Write-Host "Register the Event Handler in Project Server." -f Green
$ehDS = New-Object  WebServiceProxy.EventHandlersDataSet
$ehRow = $ehDS.EventHandlers.NewEventHandlersRow()
# Provide a friendly name and description for the event handler
$ehRow.Name = $Name
$ehRow.Description = $Description
# Provide the full name of the strongly named event handler assembly. For example: mydll, Version=1.1.0.0, Culture=neutral, PublicKeyToken=xxxxxxxxxxxxxxxx.
$ehRow.AssemblyName = $AssemblyName
# Provide the fully qualified name of the class that implements the event handler functionality.
$ehRow.ClassName = $ClassName
# Provide the id of the event you would like to hook your event on. You can use the enum as demonstrated below.
$ehRow.EventId = $EventId
# Provide the order for the event handler. If there are multiple event handlers associated with this event, the order number will determine the sequence in which the event handlers will be be executed.
$ehRow.Order = $Order;
# Optionally, only 2013. Provide the WCF Endpoint URL. For example: http://www.example.com/RemoteEventService.svc.
$ehRow.EndpointUrl = $EndpointUrl
$ehRow.EventHandlerUid = [System.Guid]::NewGuid()
$ehDS.EventHandlers.AddEventHandlersRow($ehRow)
$svcPSEvents.CreateEventHandlerAssociations($ehDS)
Write-Host "Done. It will take a minute to become visible in the server settings page of Project Server." -f Green
```

The result:

 ![](Images\scriptblog_registerpseventhandlers.png)

