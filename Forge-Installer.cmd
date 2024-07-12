@echo off
setlocal

rem Chiedi all'utente di specificare la destinazione
set LOG=.\forge-1.19.2-43.4.2-installer.jar.log
set INSTALL_FOLDER=.\MoonBase2\Server\
set DOWNLOAD_FOLDER=.\MoonBase2\Config\Temp\Forge\

rem Configura il nome dell'installer e l'URL di download
set FORGE_INSTALLER_NAME=forge-1.19.2-43.4.2-installer.jar
set FORGE_INSTALLER_URL=https://maven.minecraftforge.net/net/minecraftforge/forge/1.19.2-43.4.2/forge-1.19.2-43.4.2-installer.jar

rem Scarica l'installer utilizzando curl
echo Scaricamento dell'installer di Forge...
curl -# -o "%DOWNLOAD_FOLDER%%FORGE_INSTALLER_NAME%" %FORGE_INSTALLER_URL%
pause
rem Verifica se il download è riuscito
if not exist "%DOWNLOAD_FOLDER%%FORGE_INSTALLER_NAME%" (
    echo Errore: Download fallito o file non trovato: %FORGE_INSTALLER_NAME%
    goto :End
)
pause
rem Verifica se il file è un JAR valido
echo Verifica dell'integrità del file JAR...
java -jar "%DOWNLOAD_FOLDER%%FORGE_INSTALLER_NAME%" --help >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Errore: File JAR non valido o corrotto: %FORGE_INSTALLER_NAME%
    goto :End
)
pause
rem Esegui l'installer di Forge nella destinazione specificata
echo Installazione del server Forge in %DOWNLOAD_FOLDER%...
java -jar "%DOWNLOAD_FOLDER%%FORGE_INSTALLER_NAME%" --installServer %INSTALL_FOLDER% <nul
if %ERRORLEVEL% EQU 0 (
    move %LOG% %INSTALL_FOLDER%
    echo Installazione completata con successo.
) else (
    echo Errore durante l'installazione.
)
pause
:End
rem Fine dello script
echo Script terminato.
endlocal
pause
