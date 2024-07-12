@echo off
cls
rem Folder path
set "DMB2=.\MoonBase2"
set "DConfig=Config"
set "DServer=Server"
set "DKey=Key"
set "DTemp=Temp"
set "DTools=Tools"
rem file for program works
set "FKey=Key.txt"
set "FRun=Run.txt"



::Run as Administrator
::========================================================================================================================================
:init
setlocal DisableDelayedExpansion
set cmdInvoke=1
set winSysFolder=System32
set "batchPath=%~dpnx0"
rem this works also from cmd shell, other than %~0
for %%k in (%0) do set batchName=%%~nk
    set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
    setlocal EnableDelayedExpansion

:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
    echo Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
    echo args = "ELEV " >> "%vbsGetPrivileges%"
    echo For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
    echo args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
    echo Next >> "%vbsGetPrivileges%"
  
if '%cmdInvoke%'=='1' goto InvokeCmd 
    echo UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
    goto ExecElevation

:InvokeCmd
echo args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
echo UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
"%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
exit /B

:gotPrivileges
setlocal & cd /d %~dp0
if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)



::FirstRun
::========================================================================================================================================
setlocal
REM Definizione delle variabili
set "CheckPath=%DMB2%\%DConfig%\%DKey%"

REM Verifica se il file esiste
if not exist "%CheckPath%%FRun%" (
    :: Debug: Messaggio di creazione directory
    mkdir "%DMB2%"
    mkdir "%DMB2%\%DConfig%"
    mkdir "%DMB2%\%DConfig%\%DKey%"
    mkdir "%DMB2%\%DConfig%\%DTemp%"
    mkdir "%DMB2%\%DServer%"
    goto :dwadawdawf
    if not exist ".\%DTools%" (
        mkdir "%DMB2%\%DConfig%\%DTools%"
        rem set EULA_NAME=EULA.CMD
        rem set "EULA_URL=https://drive.google.com/uc?export=download&id=1ECtRcx7TAvyh_h2IljibBsO4AMt2Dnty"
        rem curl -# -o "%DMB2%\%DConfig%\%DTools%\%EULA_NAME%" "%EULA%"
        Echo download?
    ) else (
        move "%DTools%" "%DMB2%\%DConfig%\"
    )
    :dwadawdawf
    echo 0 > "%CheckPath%\%FRun%"
    echo Key to use the tools > "%CheckPath%\%FKey%"
) else (
    set /p numero=<"%CheckPath%\%FRun%"
    set /a numero+=1
    echo !numero! > "%CheckPath%\%FRun%"
)
endlocal

::MainMenu
::========================================================================================================================================
:MainMenu
setlocal enabledelayedexpansion
title Moon Base 2 Server - Main Menu

cls
echo Select a program:
echo.
echo [1] Install/Update JDK 17
echo [2] Install Forge Server
echo [3] Start server configuration
echo [4] Accept EULA
echo [5] Start Menu or Server at Power on
echo [6] Moon Base 2 Server Version
echo [7] Exit
echo.
set /p option="Program: "
::if "%option%"=="1" cls & goto :InstallJDK
if "%option%"=="1" cls & call ".\MoonBase2\Config\Tools\JDK-Installer.cmd"
if "%option%"=="2" cls & goto :InstallForge
if "%option%"=="3" cls & goto :AutoConfiguration
if "%option%"=="4" cls & goto :EULA
if "%option%"=="5" cls & goto :StartUP
if "%option%"=="6" cls & goto :ServerVersion
if "%option%"=="7" exit

echo Invalid choice. Press a key to continue...
pause > nul
endlocal
goto :MainMenu

::[1] Install JDK
::========================================================================================================================================

:: [2] InstallForge
::========================================================================================================================================

:: [3] startup
::========================================================================================================================================

:: [4] EULA
::========================================================================================================================================

:: [5] startup
::========================================================================================================================================

:: [6] ServerVersion
::========================================================================================================================================
