# Clear Windows update issues
# James Holmes
# Updated: 2024-11-11 - Lest we Forget.
#    On this Remembrance Day, let us remember all those brave men and women who sacrificed their lives for the country.
#
# This script must be run as administrator or run in elevated command prompt
# Run: Set-ExecutionPolicy Bypass -Force 
# Ref: https://woshub.com/install-language-pack-windows-powershell/


Get-InstalledLanguage
Install-Language -Language fr-CA
Copy-UserInternationalSettingsToSystem -WelcomeScreen $true -NewUser $true

Get-SystemPreferredUILanguage
Set-SystemPreferredUILanguage -Language fr-CA
# Restart-Computer