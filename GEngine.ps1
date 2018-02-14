$host.ui.RawUI.WindowTitle = "GEngine v1 | Created by RainbowDynamix & lighthouse64"
<#
CyberPatriot Scoring Engine
Authors: RainbowDynamix & lighthouse64

Usage: Deploy an image-specific scoring engine on your practice image to test your team as if they were in a real competition.
-------------------------------------------------------------------------------------------------------------------------------
Functionality:
- Run as a scheduled task (NT AUTHORITY\SYSTEM)
- Generate score report with a timer. (hh:mm:ss)
- Score based off specific configs
- Export setup script to deploy
#>

# Don't worry about this.. Just defining stuff..
function GetRawDate {
	$Month = (Get-Date | Select Month).Month
	$Day = (Get-Date | Select Day).Day
	$Year = (Get-Date | Select Year).Year
	$Hours = (Get-Date | Select Hour).Hour
	$Minutes = (Get-Date | Select Minute).Minute
	$Seconds = (Get-Date | Select Second).Second	
}

# Report Generated At: M/D/YYYY hh:mm:ss
# Approximate Running Time: hh:mm:ss
function WriteInfo {
	$OSdescription = (Get-WmiObject -Class win32_operatingsystem | Select-Object Description).Description
	$OSSplit = $OSdescription.Replace("Microsoft ","")
	$CurrentUser = $env:UserName
	mkdir C:\Fake_CCS | Out-Null
	$url = "https://raw.githubusercontent.com/lighthouse64/Powershell-Scoring-Engine-for-Cyberpatriot/master/kappa.ico"
	$wc = New-Object System.Net.WebClient
	$wc.DownloadFile($url, "C:\Fake_CCS\kappa.ico")
	$Desktop = "C:\Users\$CurrentUser\Desktop"
	Write-Host "[*] Writing Base Scoring Report..." -foregroundcolor Yellow
	$htmlFile = "C:\Fake_CCS\Scoring Report.html"
	echo "<!DOCTYPE html>" | Out-File $htmlFile | Out-Null
	echo "<html>" | Out-File $htmlFile -Append | Out-Null
	echo "<head>" | Out-File $htmlFile -Append| Out-Null
	echo "<title>Scoring Report</title>" | Out-File $htmlFile -Append | Out-Null
	echo "</head>" | Out-File $htmlFile -Append | Out-Null
	echo "<style>" | Out-File $htmlFile -Append| Out-Null
	echo "body {" | Out-File $htmlFile -Append| Out-Null
	echo "font-family:verdana;" | Out-File $htmlFile -Append | Out-Null
	echo "}" | Out-File $htmlFile -Append | Out-Null
	echo "</style>" | Out-File $htmlFile -Append | Out-Null
	echo "<body>" | Out-File $htmlFile -Append | Out-Null
	echo "<br>" | Out-File $htmlFile -Append | Out-Null
	echo "<h1><center>$OSSplit</center></h1>" | Out-File $htmlFile -Append | Out-Null
	echo "<p><center>Report Generated At: N/A</center></p>" | Out-File $htmlFile -Append | Out-Null
	echo "<p><center>Approximate Running Time: N/A</center></p>" | Out-File $htmlFile -Append | Out-Null
    echo "<br>" | Out-File $htmlFile -Append | Out-Null
	echo "<p>X out of Y scored security issues fixed</p>" | Out-File $htmlFile -Append | Out-Null
	echo "</body>" | Out-File $htmlFile -Append | Out-Null
	echo "</html>" | Out-File $htmlFile -Append | Out-Null
	$AppLocation = "C:\Fake_CCS\Scoring Report.html"
	$WshShell = New-Object -ComObject WScript.Shell
	$Shortcut = $WshShell.CreateShortcut("$Desktop\Scoring Report.lnk")
	$Shortcut.TargetPath = $AppLocation
	$Shortcut.IconLocation = "C:\Fake_CCS\kappa.ico"
	$Shortcut.Description ="Scoring"
	$Shortcut.WorkingDirectory ="C:\Fake_CCS"
	$Shortcut.Save()
}

# Prompt the user with main options
Clear-Host 
Write-Host "-------------------------------" -foregroundcolor Green
Write-Host "|         GEngine v.1         |" -foregroundcolor Green
Write-Host "-------------------------------" -foregroundcolor Green
Write-Host "Created by: " -foregroundcolor White -nonewline; Write-Host "RainbowDynamix " -foregroundcolor Cyan -nonewline; Write-Host "& " -foregroundcolor White -nonewline; Write-Host "lighthouse64" -foregroundcolor Magenta;
Write-Host "*WARNING: MAKE SURE YOU ARE RUNNING THIS ON YOUR PRACTICE IMAGE!" -foregroundcolor Red
Write-Host `n
Write-Host "Choose an option:" 
Write-Host "-------------------------------------------" -foregroundcolor Green
Write-Host "1. Generate Vulnerability Configuration" -foregroundcolor Yellow
Write-Host "2. Exit" -foregroundcolor Yellow
Write-Host "-------------------------------------------" -foregroundcolor Green
Write-Host `n
$Option = Read-Host "GEngine>"
if($Option -eq "1") {
	WriteInfo
} 
if($Option -eq "2") {
	exit
}

