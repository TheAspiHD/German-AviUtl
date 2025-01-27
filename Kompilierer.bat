@echo off
TITLE Kompilieren des deutschen AviUtl Sprachenpaketes Version 1.6

:: Pfaddefinitonen
SET MINGW_PATH="C:\MinGW\bin"
SET AVIUTL_DE_PATH="ÄNDERN"
SET AVIUTL_EN_PATH="ÄNDERN"

:: MinGW Pfaddefiniton
SET PATH=%MINGW_PATH%;%PATH%
::Überprüfung
echo MinGW Pfad                            %MINGW_PATH%
echo Pfad der Deutschen Sprachresource     %AVIUTL_DE_PATH%
echo Pfad von AviUtl in Englisch           %AVIUTL_EN_PATH%
echo --------------------------------------------------------------------------------------------------------
CHOICE /C JN /M "Sind die angaben richtig?"

IF ERRORLEVEL J GOTO :Kompilierung
IF ERRORLEVEL N GOTO :Fehlerhaft
:Kompilierung
:: Kompilierungsprozess
windres.exe -v --input-format=rc --output-format=coff "%AVIUTL_DE_PATH%\de_resource.rc" -o "%AVIUTL_DE_PATH%\de_resource.res"
gcc -Os -m32 -s -o "%AVIUTL_DE_PATH%\DeMod.aul" -shared -Wl,-s "%AVIUTL_DE_PATH%\de_resource.res"

:: Kompilierungserfolgsnachricht
echo Kompilierung erfolgreich!

:: Temporäre Dateien entfernen
del "%AVIUTL_EN_PATH%\DeMod.aul"

:: Copia il file compilato nella directory corretta
copy "%AVIUTL_DE_PATH%\DeMod.aul" "%AVIUTL_EN_PATH%\"

:: Nachricht vor dem Beenden
echo Dateien erfolgreich in AviUtl importiert!
echo Bitte AviUtl starten, Sprache auf Deutsch festlegen und dann AviUtl neustarten!

:: Pausierung
pause
goto end

:Fehlerhaft

echo Ihre Angaben waren Fehlerhaft!
echo BItte berichtigen sie die Angaben!

:end

exit