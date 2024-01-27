@echo off
setlocal

if exist %SystemRoot%\py.exe (
    for /f "usebackq tokens=3" %%i in (`py -0p 2^>nul`) do (
        set PYTHONHOME=%%~dpi
        goto :BRK
    )
) else (
    echo This script use py.exe installing with the installer of python.org.
    goto :eof
)

:BRK
if exist Lib (
    PowerShell -Command .\has_new_ver
    if if %ERRORLEVEL% equ 1 (
        set OPT=-U
        echo Updating Lib
    ) else (
        echo No need to update Lib
        goto :eof
    )
) else (
    echo Creating Lib
)

%PYTHONHOME%\Scripts\pip %OPT% ^
    -r requirements.txt -t .\Lib install 1>nul 2>&1

