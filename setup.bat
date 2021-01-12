@echo off
echo "1. Copy DetoursLog.dll to %WINDIR%\System32..."
set SYSTEM32_PATH=%WINDIR%\System32
copy DetoursLog.dll %SYSTEM32_PATH%\DetoursLog.dll
echo "2. Register FileAccessMonitor to taskschd..."
schtasks /create /tn "File Access Monitor" /sc "ONLOGON" /rl HIGHEST /tr "%~dp0%\FileAccessMonitor.exe"
echo "3. Register send.bat to taskschd..."
schtasks /create /tn "File Access Log Sender" /sc "DAILY" /st 00:00 /ru system /tr "%~dp0%\send.bat"
echo "Install Succeeded. OS will automatically restarts after 10 seconds..."
shutdown -r -t 10
timeout 10 > NUL