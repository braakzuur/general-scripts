# Install Canadian French (ca-FR) and change all regional settings for all new users
# James Holmes
# Updated: 2024-11-11 - Lest we Forget.
#    On this Remembrance Day, let us remember all those brave men and women who sacrificed their lives for the country.
#
# Pre-requisite: Install ca-FR LP for Office and Windows from Software Center
#
# This script must be run as administrator or run in elevated PowerShell/PowerShell ISE
# Run the following before execution: Set-ExecutionPolicy Bypass -Force 
#
# Ref: https://github.com/letsdoautomation/powershell/blob/main/Windows%2011%20Configure%20regional%20settings/README.md
#    : https://github.com/letsdoautomation/powershell/blob/main/Get-InstalledLanguage%2C%20Install-Language%2C%20Get%20and%20Set-SystemPreferredUILanguage/README.md
#    : https://learn.microsoft.com/en-us/windows/win32/intl/table-of-geographical-locations?redirectedfrom=MSDN

if (([System.Security.Principal.WindowsPrincipal] [System.Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)){
	#Clear Screen
	cls
	Write-Host "---------------------------" -ForegroundColor DarkCyan
	""
	Write-Host "Run as admin - SUCCESSFUL" -ForegroundColor Green
	""
	Write-Host "---------------------------" -ForegroundColor DarkCyan
	Start-Sleep -Seconds 1
}

$region = "fr-CA"

Get-InstalledLanguage
Set-SystemPreferredUILanguage $region

Set-Culture $region
Set-WinSystemLocale $region
Set-WinUserLanguageList $region, "en-us" -force -wa silentlycontinue
# Set-WinHomeLocation 39 # don't really need this, but feel free to uncomment if need be

# copy regional settings to new user accounts and welcome screen
Copy-UserInternationalSettingsToSystem -WelcomeScreen $True -NewUser $True