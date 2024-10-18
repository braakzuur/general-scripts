#Clear Windows update issues
#James Holmes
#Updated: 2024-10-18
#
#This script must be run as administrator or run in elevated command prompt

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
else {
	#Clear Screen
	cls
	Write-Host "Run as admin - FAILED - Exiting." -ForegroundColor Red
	Start-Sleep -Seconds 2
	exit
}

#----
#Clear CCM Cache
""
Write-Host "Clearing CCM Cache" -ForegroundColor Yellow -BackgroundColor Green

$MinDays = 0
$UIResourceMgr = New-Object -ComObject UIResource.UIResourceMgr
$Cache = $UIResourceMgr.GetCacheInfo()
$Cache.GetCacheElements() |
where-object {[datetime]$_.LastReferenceTime -lt (get-date).adddays(-$mindays)} |
foreach {
$Cache.DeleteCacheElement($_.CacheElementID)
}

""
Write-Host "---------------------------" -ForegroundColor DarkCyan
Start-Sleep -Seconds 1
""

Write-Host "Stopping Services" -ForegroundColor White -BackgroundColor Red
#Stop Windows Update Service
Write-Host "Stopping Windows Update Service" -f yellow
Stop-Service -Name "wuauserv"

#Stop Windows Cryptographic Service
Write-Host "Stopping Windows Cryptographic Service" -f yellow
Stop-Service -Name "cryptSvc"

#Stop Background Intelligent Transfer Service
Write-Host "Stopping BITS" -f yellow
Stop-Service -Name "bits"

#Stop Windows Installer Service
Write-Host "Stopping Windows Installer Service" -f yellow
Stop-Service -Name "msiserver"

""
Write-Host "---------------------------" -ForegroundColor DarkCyan
Start-Sleep -Seconds 1
""

#----Delete any old backups of the Software Distribution and catroot2 folders
Write-Host "Deleting any old backups of the catroot2 and SoftwareDistribution folders" -ForegroundColor White -BackgroundColor Red
$folder_cr2old = "C:\Windows\System32\catroot2.old"
if (Test-Path -Path $folder_cr2old ){
	Write-Host "Deleting old catroot2 folder" -f yellow
	Remove-Item -Path $folder_cr2old -Recurse
}

$folder_sdfolderold = "C:\Windows\SoftwareDistribution.old"
if (Test-Path -Path $folder_sdfolderold ){
	Write-Host "Deleting old SoftwareDistribution folder" -f yellow
	Remove-Item -Path $folder_sdfolderold -Recurse
}

""
Write-Host "---------------------------" -ForegroundColor DarkCyan
Start-Sleep -Seconds 1
""

#----Rename current Software Distribution and catroot2 folders
Write-Host "'Clearing' the current catroot2 and SoftwareDistribution folders" -ForegroundColor White -BackgroundColor Green

$folder_cr2 = "C:\Windows\System32\catroot2"
if (Test-Path -Path $folder_cr2 ){
	Write-Host "Clearing the catroot2 folder" -f yellow
	Rename-Item -Path $folder_cr2 -NewName "catroot2.old"
}

$folder_sdfolder = "C:\Windows\SoftwareDistribution"
if (Test-Path -Path $folder_sdfolder ){
	Write-Host "Clearing the SoftwareDistribution folder" -f yellow
	Rename-Item -Path $folder_sdfolder -NewName "SoftwareDistribution.old"
}

""
Write-Host "---------------------------" -ForegroundColor DarkCyan
Start-Sleep -Seconds 1
""

#----Restart services
Write-Host "Restarting Services" -ForegroundColor White -BackgroundColor Green
#Start Windows Update Service
Write-Host "Starting Windows Update Service" -f green
Start-Service -Name "wuauserv"

#Start Windows Cryptographic Service
Write-Host "Starting Windows Cryptographic Service" -f green
Start-Service -Name "cryptSvc"

#Start Background Intelligent Transfer Service
Write-Host "Starting BITS" -f green
Start-Service -Name "bits"

#Start Windows Installer Service
Write-Host "Starting Windows Installer Service" -f green
Start-Service -Name "msiserver"

""
Write-Host "---------------------------" -ForegroundColor DarkCyan
Start-Sleep -Seconds 1
""