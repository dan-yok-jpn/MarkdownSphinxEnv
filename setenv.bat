@echo off
setlocal

if not exist .venv (

    call :genBat > tmp.bat
    powershell Start-Process tmp.bat -Verb runas -Wait
    del tmp.bat

    mkdir .vscode
    call :genJson > .vscode\settings.json

    call .venv\Scripts\activate.bat
    python -m pip install -U pip
    python -m pip install -r requirements.txt
    call .venv\Scripts\deactivate.bat

)
goto :eof

:genBat
    echo @echo off
    echo cd "%~dp0"
    echo echo.
    echo echo #############################################################
    echo echo ## Now Create a Virtual Environment. Please Wait a Minute. ##
    echo echo #############################################################
    echo py -m venv --system-site-packages --symlinks --clear .venv
    exit /b

:genJson
    echo {"python.defaultInterpreterPath": "${workspaceFolder}\\.venv\\Scripts\\python.exe"}
    exit /b
