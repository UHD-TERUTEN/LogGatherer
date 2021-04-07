@echo off
for /F "tokens=* USEBACKQ" %%F in (account.txt) do (
set ssh_account=%%F
)
set id_rsa_location=%HOMEDRIVE%%HOMEPATH%\.ssh\id_rsa
echo start update
echo zipping log files
tar -cf "%DATE%.zip" -C %LogGathererRoot%\Logs\ .
echo.
echo uploading zip file
echo ssh connecting to %ssh_account%...
ssh -i %id_rsa_location% %ssh_account% "mkdir logs"
scp -i %id_rsa_location% "%DATE%.zip" "%ssh_account%:logs"
del "%DATE%.zip"
echo.
echo log files have been uploaded!
echo finish