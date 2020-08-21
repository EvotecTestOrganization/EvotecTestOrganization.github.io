# Powershell script to publish multiple projects - Project Server 2010

## Original Links

- [x] Original Technet URL [Powershell script to publish multiple projects - Project Server 2010](https://gallery.technet.microsoft.com/Powershell-script-to-3b839594)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Powershell-script-to-3b839594/description)
- [x] Download: [Download Link](Download\PublishMultipleProjects.ps1)

## Output from Technet Gallery

Ever see a requirement when you need to publish multiple projects (Note that 'Not All' and 'Not Specific One') and that list of projects should be fetched through SQL query based on some JOINS and WHERE conditions?Here is the way..

PFA the powershell script file(PublishMultipleProjects.PS1) and a batch file(PublishEPMProjects.bat).So you just need to download these files and make a change in PWA URL, Database server name and most important SQL code to fetch  the projects to be published.

Once all done,run the batch file or attach it to schedule job if want to run at any specific time.

Please note the account used to run the script should be in PS2010 administrator security group.

```
$svcPSProxy = New-WebServiceProxy -uri "http://YourEPMWebApp/pwa/_vti_bin/PSI/Project.asmx?wsdl" -useDefaultCredential
    $EPMTYGUID = [system.guid]::empty
    $sqlConnection = new-object System.Data.SqlClient.SqlConnection "server=YourEPMDB;database=ProjectServerReporting;Integrated Security=SSPI"
    $sqlConnection.Open()
    #Create a command object
    $sqlCommand = $sqlConnection.CreateCommand()
    $sqlCommand.CommandText = "    SELECT ProjectUID,ProjectName,EnterpriseProjectTypeName
                                FROM MSP_EpmProject_UserView EPU
                                INNER JOIN MSP_EpmEnterpriseProjectType ET
                                ON EPU.EnterpriseProjectTypeUID =ET.EnterpriseProjectTypeUID
                                WHERE ET.EnterpriseProjectTypeName IN ('A','B','C')"
    #Execute the Command
    $sqlReader = $sqlCommand.ExecuteReader()
    $Datatable = New-Object System.Data.DataTable
    $DataTable.Load($SqlReader)
    # Close the database connection
    $sqlConnection.Close()
        $DataTable|%{
        $G = [System.Guid]::NewGuid()
        $G1 = [Guid]$_.ProjectUID
        $now = Get-Date -Format g
        Write-host "Project:" $_.ProjectName " publish is starting at " $now
        $svcPSProxy.QueuePublish("$G", $G1, "true","")
    }
```

