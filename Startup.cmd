@echo off

set "File=.\Menu.bat"
setx APPDATA "%APPDATA%" /m
set "ShellStartup=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Menu.lnk"
::set "batchFilePath=C:\path\to\your\start_script.bat"

::rem Aggiunge la chiave di registro per eseguire il file batch all'avvio
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v "MyStartupScript" /t REG_SZ /d "%File%" /f

::echo Il file batch è stato registrato per l'esecuzione all'avvio.
::pause

::set "batchFilePath=C:\path\to\your\start_script.bat"
::set "startupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

::rem Copia il file batch nella cartella Esecuzione automatica
::copy "%batchFilePath%" "%startupFolder%"
::mklink %ShellStartup% %File%

echo Il file batch è stato copiato nella cartella Esecuzione automatica.
pause
