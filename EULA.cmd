@echo off
setlocal enabledelayedexpansion

rem Cartella e file di destinazione
set Folder=.\MoonBase2\Server\
set file=%Folder%eula.txt

rem Testo da inserire nella riga modificata
set "eula_true=eula=true"
set "eula_false=eula=false"

rem Contatore per tenere traccia delle righe lette
set "Line=0"
rem Numero della riga da modificare (partendo da 1)
set "LineTarget=3"

rem Variabile temporanea per memorizzare il contenuto modificato
set "tempfile=%file%.tmp"

:eula
echo.
set /p "choice=Agree to the EULA to run the server? (y/n): "
if /i "%choice%"=="y" (
    set "eula_choice=%eula_true%"
    goto :process_file
) else if /i "%choice%"=="n" (
    set "eula_choice=%eula_false%"
    goto :process_file
) else (
    echo Invalid choice. Exiting...
    goto :end
)

:process_file
rem Legge il file e modifica solo la riga specificata
(
    for /f "tokens=*" %%a in (%file%) do (
        set /a Line+=1
        if !Line! equ %LineTarget% (
            echo %eula_choice%
        ) else (
            echo %%a
        )
    )
) > %tempfile%

rem Sostituisce il file originale con il file temporaneo
move /y %tempfile% %file%
echo Modifica completata.

:end
endlocal
pause
