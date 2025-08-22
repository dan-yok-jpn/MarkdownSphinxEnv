@echo off
setlocal enabledelayedexpansion

if not exist .venv (goto :eof)

for /f "tokens=3,3 delims= " %%i in (.venv\pyvenv.cfg) do (
    if not exist %%i (
        rmdir /s /q .venv
        rmdir /s /q .vscode
        call set_venv.bat
        set set_now=1
    )
    goto :skip
)
:skip
if "%set_now%"=="1" (

    call .venv\Scripts\activate.bat
    python -m pip install -U pip
    python -m pip install -r requirements.txt
    call .venv\Scripts\deactivate.bat

) else (

    PowerShell -Command .\has_new_ver
    if %ERRORLEVEL% equ 1 (
        call .venv\Scripts\activate.bat
        python -m pip install -U pip
        python -m pip install -U -r requirements.txt
        call .venv\Scripts\deactivate.bat
        set set_now=1
    ) 

)
if "%set_now%"=="1" (

    set /p RES="Do you rebuild dpcuments of all projects ? (y/n)"
    if not "%RES%" == "y" (goto :eof)
    make_all

)