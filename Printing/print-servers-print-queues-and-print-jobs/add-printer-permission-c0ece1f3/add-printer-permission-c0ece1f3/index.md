# Add Printer Permission

## Original Links

- [x] Original Technet URL [Add Printer Permission](https://gallery.technet.microsoft.com/Add-Printer-Permission-c0ece1f3)
- [x] Original Technet Description URL [Description](https://gallery.technet.microsoft.com/Add-Printer-Permission-c0ece1f3/description)
- [x] Download: [Download Link](Download\Add-LHSPrinterPermissionSDDL.ps1)

## Output from Technet Gallery

Windows Server 2012 comes with the PrintManagement module, which makes automation Management of Printers easier. But testing cmdlets like Add-Printer and Set-Printer I noticed that you can set Printer Permission only using the Parameter -PermissionSDDL .  These Parameters in both cmdlets expect Printer Permission using Security Definition Description Language (SDDL) which is not what you can type on the command line that easy.

Therefore, a complete SDDL string may look like this (one line, formatted for appearance)

**D:**(A;;CC;;;AU)(A;;CCLCRPRC;;;IU)(A;;CCLCRPRC;;;SU)(A;;CCLCRPWPRC;;;SY)(A;;KA;;;BA)

(A;;KA;;;S-1-5-21-1234565538-1234563583-123456993-1234)**S:**(AU;FA;KA;;;WD)(AU;OIIOFA;GA;;;WD)

see this site for more details:http://networkadminkb.com/KB/a6/understanding-the-sddl-permissions-in-the-ace-string.aspx

These was the reason for me to create an advenced function to set Printer Permission in the way Admins used to do like using domain\groupname or domain\username.

Example of usage:

$PermissionSDDL = Get-Printer -full -Name test99 | select PermissionSDDL -ExpandProperty PermissionSDDL

     $newSDDL = Add-LHSPrinterPermissionSDDL -Account "Domain\Username" -existingSDDL $PermissionSDDL

     Get-Printer -Name test99 | Set-Printer -PermissionSDDL $newSDDL -verbose

Description:

we first get the existing SDDL string from the Printer using the cmdlet Get-Printer from the microsoft PrintManagement module (which has also a   -computerName parameter). We create a new SDDL String with the Additional Permission  using the Function  Add-LHSPrinterPermissionSDDL.

finaly we can set the new SDDL string to the Printer using the Set-Printer cmdlet from the Microsoft PrintManagement Module (which has also a   -computerName parameter).

```
Function Add-LHSPrinterPermissionSDDL
{
<#
.SYNOPSIS
    Add Printer Permission using SDDL
.DESCRIPTION
    Add Printer Permission using Security Definition Description Language (SDDL).
    The function adds full controll rights to the SDDL
    Use Get-Printer and Set-Printer to modify Printer Permission on
    local and Remote Computers. Requires Microsoft PS Module PrintManagement.
.PARAMETER Account
    An User or Group account you want to add Permission
    like "Domain\GroupName" or "Domain\UserName".
.PARAMETER existingSDDL
    The current SDDL of a Printer
.EXAMPLE
    $PermissionSDDL = Get-Printer -full -Name test99 | select PermissionSDDL -ExpandProperty PermissionSDDL
    $newSDDL = Add-LHSPrinterPermissionSDDL -Account "Domain\Username" -existingSDDL $PermissionSDDL
    Get-Printer -Name test99 | Set-Printer -PermissionSDDL $newSDDL -verbose
.INPUTS
    None
.OUTPUTS
    SDDL as System.String
.NOTES
    # AccessMask which can contain following values:
    # Takeownership - 524288
    # ReadPermissions - 131072
    # ChangePermissions - 262144
    # ManageDocuments - 983088
    # ManagePrinters - 983052
    # Print + ReadPermissions - 131080
    # full control all operations - 268435456
    AUTHOR: Pasquale Lantella
    LASTEDIT:
    KEYWORDS:
.LINK
    DiscretionaryAcl.AddAccess Method (AccessControlType, SecurityIdentifier, Int32, InheritanceFlags, PropagationFlags)
    http://msdn.microsoft.com/en-us/library/xs9aw56y.aspx
    Understanding the SDDL permissions in the ACE_String
    http://networkadminkb.com/KB/a6/understanding-the-sddl-permissions-in-the-ace-string.aspx
#Requires -Version 3.0
#>
[cmdletbinding(
    ConfirmImpact = 'Low',
    SupportsShouldProcess = $false
)]
[OutputType('System.String')]
param(
    [Parameter(Position=0,Mandatory=$True,ValueFromPipeline=$False,
        HelpMessage='A Security Group or User like "Domain\GroupName" or "Domain\UserName"')]
    [String]$Account,
    [Parameter(Position=1,Mandatory=$True,ValueFromPipeline=$False)]
    [String]$existingSDDL
)
BEGIN {
    Set-StrictMode -Version Latest
    ${CmdletName} = $Pscmdlet.MyInvocation.MyCommand.Name
} # end BEGIN
PROCESS {
    try
    {
        $isContainer = $false
        $isDS = $false
        $SecurityDescriptor = New-Object -TypeName `
            Security.AccessControl.CommonSecurityDescriptor `
            $isContainer, $isDS, $existingSDDL
        Write-Verbose "Adding Permission for Group $Account"
        #get the SID for the specified Group and add it to the SDDL
        $NTAccount = New-Object Security.Principal.NTAccount $Account
        $NTAccountSid = $NTAccount.Translate([Security.Principal.SecurityIdentifier]).Value
        $SecurityDescriptor.DiscretionaryAcl.AddAccess(
            [System.Security.AccessControl.AccessControlType]::Allow,
            $NTAccountSid,
            268435456, #full control all operations
            [System.Security.AccessControl.InheritanceFlags]::None,
            [System.Security.AccessControl.PropagationFlags]::None) | Out-Null
        return $SecurityDescriptor.GetSddlForm("All")
    }
    catch [Exception]
    {
        Write-Error -Message "Failed To Generate SDDL (review inner exception):`n $_.Message" `
            -Exception $_.Exception
    }
} # end PROCESS
END { Write-Verbose "Function ${CmdletName} finished." }
} #end Function Add-LHSPrinterPermissionSDDL
```

