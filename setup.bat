@echo off
echo 1. Copy DetoursLog.dll to %WINDIR%\System32...
set SOURCE_PATH=%~dp0%DetoursLog*.dll
set TARGET_PATH=%WINDIR%\System32\
copy "%SOURCE_PATH%" "%TARGET_PATH%"
set SOURCE_PATH=%~dp0%DetoursLog32.dll
set TARGET_PATH=%WINDIR%\SysWOW64\
copy "%SOURCE_PATH%" "%TARGET_PATH%"
setx /M LogGathererRoot "%LOCALAPPDATA%\LogGatherer"
echo 2. Copy Files to %LogGathererRoot%...
mkdir "%LogGathererRoot%\Logs"
set SOURCE_PATH=%~dp0%*
copy "%SOURCE_PATH%" "%LogGathererRoot%"
echo 3. Register FileAccessMonitor to taskschd...
schtasks /create /tn "File Access Monitor 32-bit" /sc "ONLOGON" /rl HIGHEST /tr "%LogGathererRoot%\FileAccessMonitor32.exe"
schtasks /create /tn "File Access Monitor 64-bit" /sc "ONLOGON" /rl HIGHEST /tr "%LogGathererRoot%\FileAccessMonitor64.exe"
echo 4. Register send.bat to taskschd...
schtasks /create /tn "File Access Log Sender" /sc "DAILY" /rl HIGHEST /st 13:00 /tr "%LogGathererRoot%\send.bat"
echo Install Succeeded. OS will automatically restarts after 10 seconds..."
shutdown -r -t 10
timeout 10 > NUL