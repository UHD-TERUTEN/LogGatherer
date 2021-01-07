@echo off
for /F "tokens=* USEBACKQ" %%F in (account.txt) do (
set ssh_account=%%F
)
set id_rsa_location=%HOMEDRIVE%%HOMEPATH%\.ssh\id_rsa
echo start update
echo upload log file
echo.
echo ssh connects to %ssh_account%...
ssh -i %id_rsa_location% %ssh_account% "mkdir logs"
echo.
echo sftp connects to %ssh_account%...
sftp -b upload.txt -i %id_rsa_location% %ssh_account%
echo.
echo upload log file done!
echo finish
