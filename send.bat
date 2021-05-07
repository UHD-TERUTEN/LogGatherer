@echo off
for /F "tokens=* USEBACKQ" %%F in (%LogGathererRoot%\account.txt) do (
set ssh_account=%%F
)
set id_rsa_location=%HOMEDRIVE%%HOMEPATH%\.ssh\id_rsa
echo start update
echo zipping log files
mkdir "%LogGathererRoot%\Logs\%DATE%"
move %LogGathererRoot%\Logs\*.txt "%LogGathererRoot%\Logs\%DATE%"
tar -zcvf "%LogGathererRoot%\Logs\%DATE%\%DATE%.tar.gz" -C %LogGathererRoot%\Logs\%Date% .
echo.
echo uploading zip file
echo ssh connecting to %ssh_account%...
ssh -i %id_rsa_location% %ssh_account% "mkdir logs"
scp -i %id_rsa_location% "%LogGathererRoot%\Logs\%DATE%\%DATE%.tar.gz" "%ssh_account%:logs"
rmdir /s /q "%LogGathererRoot%\Logs\%DATE%"
echo.
echo log files have been uploaded!
echo finish