@echo off
echo 1. Copy DetoursLog.dll to %WINDIR%\System32...
set SOURCE_PATH=%~dp0%DetoursLog.dll
set TARGET_PATH=%WINDIR%\System32\DetoursLog.dll
copy "%SOURCE_PATH%" "%TARGET_PATH%"
setx LogGathererRoot "%LOCALAPPDATA%\LogGatherer"
echo 2. Copy Files to %LogGathererRoot%...
mkdir "%LogGathererRoot%\Logs"
set SOURCE=%~dp0%*
copy "%SOURCE%" "%LogGathererRoot%"
echo 3. Register FileAccessMonitor to taskschd...
schtasks /create /tn "File Access Monitor" /sc "ONLOGON" /rl HIGHEST /tr "%LogGathererRoot%\FileAccessMonitor.exe"
echo 4. Register send.bat to taskschd...
schtasks /create /tn "File Access Log Sender" /sc "DAILY" /st 00:00 /ru system /tr "%LogGathererRoot%\send.bat"
echo Install Succeeded. OS will automatically restarts after 10 seconds..."
shutdown -r -t 10
timeout 10 > NUL