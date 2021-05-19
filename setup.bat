@echo off
echo 1. Copy DetoursLog.dll to %WINDIR%\System32...
set SOURCE_PATH=%~dp0%DetoursLog*.dll
set TARGET_PATH=%WINDIR%\System32\
copy "%SOURCE_PATH%" "%TARGET_PATH%"
set SOURCE_PATH=%~dp0%DetoursLog32.dll
set TARGET_PATH=%WINDIR%\SysWOW64\
copy "%SOURCE_PATH%" "%TARGET_PATH%"
set LOG_GATHERER_ROOT="%LOCALAPPDATA%\LogGatherer"
echo 2. Copy Files to %LOG_GATHERER_ROOT%...
setx /M LogGathererRoot %LOG_GATHERER_ROOT%
mkdir "%LOG_GATHERER_ROOT%\Logs"
set SOURCE_PATH=%~dp0%*
copy "%SOURCE_PATH%" "%LOG_GATHERER_ROOT%"
echo 3. Register FileAccessMonitor to taskschd...
schtasks /create /tn "File Access Monitor 32-bit" /sc "ONLOGON" /rl HIGHEST /tr "%LOG_GATHERER_ROOT%\FileAccessMonitor32.exe"
schtasks /create /tn "File Access Monitor 64-bit" /sc "ONLOGON" /rl HIGHEST /tr "%LOG_GATHERER_ROOT%\FileAccessMonitor64.exe"
echo 4. Register send.bat to taskschd...
schtasks /create /tn "File Access Log Sender" /sc "DAILY" /rl HIGHEST /st 13:00 /tr "%LOG_GATHERER_ROOT%\send.bat"
echo Install Succeeded. OS will automatically restarts after 10 seconds..."
shutdown -r -t 10
timeout 10 > NUL