# How to Branding Project Server 2010(PWA) site  with SharePoint Designer 2010

## Original Links

- [x] Original Technet URL [How to Branding Project Server 2010(PWA) site  with SharePoint Designer 2010](https://gallery.technet.microsoft.com/How-to-Branding-PWA-with-3f4c9a89)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/How-to-Branding-PWA-with-3f4c9a89/description)
- [x] Download: Not available.

## Output from Technet Gallery

By default "PWA  site has been configured to disallow editing with SharePoint Designer"

required to do some configuration manualy.

Removing the DisableWebDesignFeatures="wdfopensite" from ONET.xml of the PWA site which is at C:\Program Files\Common Files\Microsoft Shared\Web Server Extensions\14\TEMPLATE\SiteTemplates\PWA\XML and do a iisreset.

 I guess if you can set the property of vti\_disablewebdesignfeatures2 to null of the PWA web site using code or Powershell, that will work.

During changeing master page you will get many problem with PWA site.Should be do some manulaly configuration with Web.config and Masterpage.

Once I tried simply to change master page, just to change an image. First of all I found out the master page. Project Server 2010 uses v4.master master page for all application pages. When my changes were applied I uploaded back master page to the master  page gallery. And I was surprised, now all PS pages showed me an error: “The base type 'Microsoft.Office.Project.PWA.PJBaseWebPartPage' is not allowed for this page. The type is not registered as safe”. I did rollback, but still got the same error.

It was fixed by adding the following line to the web.config:

1. &lt;SafeControl Assembly="Microsoft.Office.Project.Server.PWA, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" Namespace="Microsoft.Office.Project.PWA" TypeName="\*" Safe="True" /&gt;

Atferwards, instead of getting the previous error I got the new one: “An error occurred during the processing of /PWA/default.aspx. Code blocks are not allowed in this file”. It happened because SharePoint disabled the ability to create the server-side  scripts by default, so you had to turn it on. You are able to do that in the web.config file, in the configuration/SharePoint/PageParserPaths configuration section:

1. &lt;PageParserPath VirtualPath="/pwa/\*" CompilationMode="Always" AllowServerSideScript="true" /&gt;

But new error appeared: “The control type 'Microsoft.Office.Project.PWA.CommonControls.PageProperty' is not allowed on this page. The type is not registered as safe.”

1. &lt;SafeControl Assembly="Microsoft.Office.Project.Server.PWA, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" Namespace="Microsoft.Office.Project.PWA.CommonControls" TypeName="\*" Safe="True" /&gt;

