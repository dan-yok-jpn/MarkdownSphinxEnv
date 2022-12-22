@echo off
setlocal

set PYTHONHOME=C:\Python\Python310
set PATH=%PYTHONHOME%;%PYTHONHOME%\DLLs;%PYTHONHOME%\Scripts;%PATH%

if not exist %PYTHONHOME% (
    echo.
    echo    ERROR !   %PYTHONHOME% not found.
    echo    Check this Scripts
    echo.
    exit /b 0
)

call :genBat > tmp.bat
powershell Start-Process tmp.bat -Verb runas -Wait
del tmp.bat
pip install -r requirements.txt -t .venv\Lib\site-packages 1>nul 2>nul

.venv\Scripts\activate & set_proj.bat myProject

exit /b 0

:genBat
    echo @echo off
    echo cd "%~dp0"
    echo "%PYTHONHOME%\python" -m venv --system-site-packages --symlinks --without-pip --clear .venv
   exit /b
