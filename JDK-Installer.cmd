@echo off
setlocal
title Install JDK 17

rem Imposta il percorso della cartella e il nome del file da cercare
set "cartella=.\MoonBase2\Config\Key"
set "nome_file=Key.txt"

rem Verifica se il file esiste nella cartella specificata
if exist "%cartella%\%nome_file%" (
    goto :Program
) else (
    echo bruh
    pause
    exit /b 1
)
:Program
title Install JDK 17

:: Controlla se Java JDK è già installato
echo Check if JDK 17 is installed
echo.
timeout /t 1 /nobreak >nul
java -version >nul 2>&1
if %errorlevel% == 0 (
    echo Java JDK is already installed.
    echo.
    echo Installed Version:
    java -version
    echo.
    goto :CheckOlineVersion
    echo.
    :PrintVersion
    echo.
    goto :CheckUpdate
)

:DownloadJDK
set JDK_URL=https://download.oracle.com/java/17/latest/jdk-17_windows-x64_bin.exe
set JDK_FILENAME=jdk-17_windows-x64_bin.exe
set DEST_FOLDER=.\MoonBase2\Config\Temp\JDK\
::Creazione Cartella JDK
if not exist "%DEST_FOLDER%" (
    mkdir "%DEST_FOLDER%"
) else (
    rd /s /q ".\MoonBase2\Config\Temp\JDK"
    goto :DownloadJDK
)

echo Download JDK 17
echo.
echo From = %JDK_URL%
echo Folder = %DEST_FOLDER%%JDK_FILENAME%
echo.
echo Downloading...
curl -# -o "%DEST_FOLDER%%JDK_FILENAME%" "%JDK_URL%"
echo.
echo Download completed successfully.
echo.
echo wait 5 seconds
echo.
timeout /t 5 /nobreak >nul

set installer="%DEST_FOLDER%%JDK_FILENAME%"
if exist "%installer%" (
    echo Installing Java JDK 17...
    start /wait "" "%installer%" /s
    java -version >nul 2>&1
    if %errorlevel% == 0 (
        echo.
        echo Java JDK 17 installation completed. Computer restart is required
        goto :Restart
    ) else (
        echo.
        echo Java JDK 17 installation failed
        goto :end
    )
) else (
    echo The installer file was not found.
    echo Make sure the download completed successfully.
)

::Restart Computer
:Restart
echo.
set /p "choice=Do you want to restart your computer? (y/N): "
if "%choice%"=="y" (
    shutdown /r /t 15
    echo.
    echo The system will restart in 15 seconds
    echo.
    echo The program will close in 10 seconds
    timeout /t 10 /nobreak >nul
    exit
) else (
    echo.
    echo Restart canceled
    goto :end
)

::Check Online Version
:CheckOlineVersion
setlocal EnableDelayedExpansion
set "packageName=Oracle.JDK.17"
for /f "tokens=2 delims=: " %%a in ('winget show %packageName% ^| findstr /i "Version"') do (
    set "version=%%a"
)
echo Online Version JDK 17: %version%
goto :PrintVersion

::Update
:CheckUpdate
set /p "Check=Do you want to upgrade? (y/N): "
if /i "%Check%"=="Y" (
    echo.
    goto :DownloadJDK
) else (
    echo.
    echo Exit program
    goto :end
)

:end
endlocal
pause