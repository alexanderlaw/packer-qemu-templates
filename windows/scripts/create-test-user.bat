REM Disable PasswordComplexity requirement
secedit /export /cfg %TEMP%\secpol.cfg
powershell -Command "(Get-Content %TEMP%\secpol.cfg) | ForEach-Object {$_ -replace \"PasswordComplexity = 1\", \"PasswordComplexity = 0\"} | Set-Content %TEMP%\secpol.cfg"
secedit /configure /db %windir%\security\local.sdb /cfg %TEMP%\secpol.cfg /areas SECURITYPOLICY

REM Create user
net user test TestPass1 /add
powershell -Command "$admgroup=(New-Object System.Security.Principal.SecurityIdentifier(\"S-1-5-32-544\")).Translate([System.Security.Principal.NTAccount]).Value.Split(\"\\\")[1]; net localgroup $admgroup test /add"
WMIC UserAccount WHERE "Name='test'" SET PasswordExpires=FALSE
net user test

REM Create user profile
powershell -Command "Start-Process whoami -LoadUserProfile -Credential (new-object -typename System.Management.Automation.PSCredential -argumentlist \"test\", (convertto-securestring \"TestPass1\" -asplaintext -force))"
