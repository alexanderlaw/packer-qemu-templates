:: Download and install .Net 4.0
powershell -Command "((new-object net.webclient).DownloadFile('https://download.microsoft.com/download/9/5/A/95A9616B-7A37-4AF6-BC36-D6EA96C8DAAE/dotNetFx40_Full_x86_x64.exe', '%TEMP%\dotNetFx40_Full_x86_x64.exe'))
%TEMP%\dotNetFx40_Full_x86_x64.exe /passive /norestart

:: Download and install PowerShell 3
powershell -Command "((new-object net.webclient).DownloadFile('http://download.microsoft.com/download/E/7/6/E76850B8-DA6E-4FF5-8CCE-A24FC513FD16/Windows6.1-KB2506143-x64.msu', '%TEMP%\Windows6.1-KB2506143-x64.msu'))
wusa.exe %TEMP%\Windows6.1-KB2506143-x64.msu /quiet /norestart

:: Download and install HotFix for KB2842230
powershell -Command "((new-object net.webclient).DownloadFile('http://hotfixv4.microsoft.com/Windows%%207/Windows%%20Server2008%%20R2%%20SP1/sp2/Fix467402/7600/free/463984_intl_x64_zip.exe', '%TEMP%\463984_intl_x64.zip'))
powershell -Command "$shell = New-Object -ComObject Shell.Application; $zip_src = $shell.NameSpace('%TEMP%\463984_intl_x64.zip'); $zip_dest = $shell.NameSpace('%TEMP%'); $zip_dest.CopyHere($zip_src.Items(), 1044)"
wusa.exe %TEMP%\Windows6.1-KB2842230-x64.msu /quiet /norestart

:: Remove temporary files
del %TEMP%\*.exe
del %TEMP%\*.msu

:: start winrm
cmd /c a:\install-winrm.cmd

cmd /c a:\zz-start-sshd.cmd

del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\configure2.bat"
