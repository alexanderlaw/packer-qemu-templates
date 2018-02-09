:: %~dp0 gives the dirname of the script

:: Download Service Pack 1
powershell -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/0/A/F/0AFB5316-3062-494A-AB78-7FB0D4461357/windows6.1-KB976932-X86.exe', '%TEMP%\windows6.1-KB976932-X86.exe'))

:: Setup the script to run after the Service Pack installation
mkdir "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
copy %~dp0configure2.bat "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\"

:: Install Service Pack 1
%TEMP%\windows6.1-KB976932-X86.exe /unattend
