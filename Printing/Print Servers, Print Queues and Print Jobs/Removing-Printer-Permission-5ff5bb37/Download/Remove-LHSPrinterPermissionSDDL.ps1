Function Remove-LHSPrinterPermissionSDDL
{
<#
.SYNOPSIS
    Removes Printer Permission using SDDL

.DESCRIPTION
    Removes Printer Permission using Security Definition Description Language (SDDL).

    Use Get-Printer and Set-Printer to modify Printer Permission on 
    local and Remote Computers. Requires Microsoft PS Module PrintManagement.
    

.PARAMETER Account
    An User or Group you want to Remove Permission
    like "Domain\GroupName" or "Domain\UserName".
    
.PARAMETER existingSDDL
    The current SDDL of a Printer

.EXAMPLE
    # get the current SDDL from the Printer
    $PermissionSDDL = Get-Printer -full -Name test99 | select PermissionSDDL -ExpandProperty PermissionSDDL

    # genrate the new SDDL
    $newSDDL = Remove-LHSPrinterPermissionSDDL -Account "Domain\Username" -existingSDDL $PermissionSDDL

    # Set the new SDDL on the Printer
    Get-Printer -Name test99 | Set-Printer -PermissionSDDL $newSDDL -verbose

   
.INPUTS
    None

.OUTPUTS
    SDDL as System.String

.NOTES
    # AccessMask which can contain following values:
    # Takeownership - 524288
    # ReadPermissions - 131072
    # ChangePermissions - 262144
    # ManageDocuments - 983088
    # ManagePrinters - 983052
    # Print + ReadPermissions - 131080
    # full control all operations - 268435456
    
    AUTHOR: Pasquale Lantella 
    LASTEDIT: 
    KEYWORDS: 

.LINK
    DiscretionaryAcl.RemoveAccess Method (AccessControlType, SecurityIdentifier, Int32, InheritanceFlags, PropagationFlags)
    http://msdn.microsoft.com/en-us/library/5c4a0wc2.aspx

    Understanding the SDDL permissions in the ACE_String
    http://networkadminkb.com/KB/a6/understanding-the-sddl-permissions-in-the-ace-string.aspx


#Requires -Version 3.0
#>

[cmdletbinding(  
    ConfirmImpact = 'Low',
    SupportsShouldProcess = $false
)]  

[OutputType('System.String')]

param(
    [Parameter(Position=0,Mandatory=$True,ValueFromPipeline=$False,
        HelpMessage='A Security Group or User like "Domain\GroupName" or "Domain\UserName"')]
    [String]$Account,

    [Parameter(Position=1,Mandatory=$True,ValueFromPipeline=$False)]
    [String]$existingSDDL
)

BEGIN {

    Set-StrictMode -Version Latest
    ${CmdletName} = $Pscmdlet.MyInvocation.MyCommand.Name


} # end BEGIN

PROCESS {

    try 
    {
        $isContainer = $false
        $isDS = $false
        $SecurityDescriptor = New-Object -TypeName `
            Security.AccessControl.CommonSecurityDescriptor `
            $isContainer, $isDS, $existingSDDL


        Write-Verbose "remove Permission for $Account"
        $NTAccount = New-Object Security.Principal.NTAccount $Account
        $NTAccountSid = $NTAccount.Translate([Security.Principal.SecurityIdentifier]).Value

        $PermissionExist = $False
        Foreach ($SDDL in $SecurityDescriptor.DiscretionaryAcl)
        {
            If ($SDDL.SecurityIdentifier -match $NTAccountSid)
            {
                # found one ace_string to remove
                $PermissionExist = $True
                $SecurityDescriptor.DiscretionaryAcl.RemoveAccess(
                    [System.Security.AccessControl.AccessControlType]::Allow,
                    $SDDL.SecurityIdentifier,
                    $SDDL.AccessMask,
                    $SDDL.InheritanceFlags,
                    $SDDL.PropagationFlags) | Out-Null            
            } 

        }

        If ($PermissionExist)
        {
            return $SecurityDescriptor.GetSddlForm("All")
        }
        Else
        {
            Write-Warning -Message "Could not find any Account SIDs to remove"
            return $Null
        }
    }
    catch [Exception] 
    {
        Write-Error -Message "Failed To Generate SDDL (review inner exception):`n $_.Message" `
            -Exception $_.Exception
    }
} # end PROCESS

END { Write-Verbose "Function ${CmdletName} finished." }
} #end Function Remove-LHSPrinterPermissionSDDL

