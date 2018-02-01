REM Disable PasswordComplexity requirement
secedit /export /cfg %TEMP%\secpol.cfg
cmd /c powershell -Command "(Get-Content %TEMP%\secpol.cfg) | ForEach-Object {$_ -replace \"PasswordComplexity = 1\", \"PasswordComplexity = 0\"} | Set-Content %TEMP%\secpol.cfg"
secedit /configure /db %windir%\security\local.sdb /cfg %TEMP%\secpol.cfg /areas SECURITYPOLICY

REM Create user
net user test TestPass1 /add
Set AdmGroupSID=S-1-5-32-544
Set AdmGroup=
For /F "UseBackQ Tokens=1* Delims==" %%I In (`WMIC Group Where "SID = '%AdmGroupSID%'" Get Name /Value ^| Find "="`) Do Set AdmGroup=%%J
Set AdmGroup=%AdmGroup:~0,-1%
net localgroup %AdmGroup% test /add
wmic USERACCOUNT WHERE "Name='test'" set PasswordExpires=FALSE

REM Create user profile
powershell -Command "Start-Process whoami -LoadUserProfile -Credential (new-object -typename System.Management.Automation.PSCredential -argumentlist \"test\", (convertto-securestring \"TestPass1\" -asplaintext -force))"
