#Script to apply windows updates

Start-Transcript -Path "C:\Logs\windowsupdates-$(get-date -f yyyy-MM-dd-hh-mm).txt" -Verbose

#Needed for communication
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force

Install-Module -Name PSWindowsUpdate -Force

Install-WindowsUpdate -AcceptAll -Install -IgnoreReboot | Out-File "c:\logs\$(get-date -f yyyy-MM-dd-hh-mm)-WindowsUpdate.log" -force
#start-sleep -Seconds 30 -Verbose

Stop-Transcript -Verbose

"completed" >> "C:\Logs\windowsupdates-done.txt"