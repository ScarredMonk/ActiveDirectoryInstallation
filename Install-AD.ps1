<#
================================================================================================
    AD Installer Script: InstallAD.ps1

    Powershell script to automate the installation of active directory forest. 

    Author: Scarred Monk (@ScarredMonk)

================================================================================================
#>

<#
.Synopsis
   Adds the required roles to install AD forest and then installs forest with the entered name.  
.DESCRIPTION
   The goal of AD Installer script is to automate the AD installation part using powershell. 
.EXAMPLE
   Import-Module .\ADInstaller.ps1; Invoke-ADInstaller -DomainName rootdse.org
#>

Write-Host ""
function DisplayInfo {
    $info = 'Invoke-ADForest deployment script'
	Write-Host $info -ForegroundColor "Yellow"
}

function InstallADRole {
    Write-Host "[+] Installing required AD Roles and features." -ForegroundColor 'Green'
    Install-windowsFeature AD-Domain-Services
    Add-windowsfeature RSAT-ADDS
    Import-Module ADDSDeployment
    Write-Host "`n`nAD Roles and features are installed.`n`n" -ForegroundColor "Gray"
    }

function ADforestInstall {
Write-Host "[+] Installing AD forest $DomainName" -ForegroundColor 'Green'
$DomainNetBiosName = $DomainName.split('.')[0]
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\\Windows\\NTDS" -DomainMode "7" -DomainName $DomainName -DomainNetbiosName $DomainNetBiosName -ForestMode "7" -InstallDns:$true -LogPath "C:\\Windows\\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\\Windows\\SYSVOL" -Force:$true -SkipPreChecks -SafeModeAdministratorPassword $pass  -WarningAction silentlyContinue
Write-Host "`n`n$DomainName has been installed successfully. Domain controller will restart`n`n" -ForegroundColor 'Gray'
}

function Invoke-ADInstaller
{
    Param
    ([Parameter(Mandatory=$true, Position=0)] [string] $DomainName)
    $pass = Read-Host -Prompt "Set Safe Mode Administrator Password" -AsSecureString
    DisplayInfo
    InstallADRole
    ADforestInstall
}