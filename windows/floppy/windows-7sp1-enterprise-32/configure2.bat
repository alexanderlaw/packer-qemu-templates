:: Download and install .Net 4.0
powershell -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe', '%TEMP%\dotNetFx40_Full_x86_x64.exe'))
%TEMP%\dotNetFx40_Full_x86_x64.exe /passive /norestart

:: Download and install PowerShell 3
powershell -Command "((new-object net.webclient).DownloadFile('http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x86.msu', '%TEMP%\Windows6.1-KB2506143-x86.msu'))
wusa.exe %TEMP%\Windows6.1-KB2506143-x86.msu /quiet /norestart

:: Download and install HotFix for KB2842230
powershell -Command "((new-object net.webclient).DownloadFile('https://oc.postgrespro.ru/index.php/s/MSkk7z7nFXPphOD/download', '%TEMP%\Windows6.1-KB2842230-x86.msu'))
wusa.exe %TEMP%\Windows6.1-KB2842230-x86.msu /quiet /norestart

:: Remove temporary files
del %TEMP%\*.exe
del %TEMP%\*.msu

:: start winrm
cmd /c a:\install-winrm.cmd

cmd /c a:\zz-start-sshd.cmd

del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\configure2.bat"
