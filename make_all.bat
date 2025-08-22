@echo off
setlocal enabledelayedexpansion

set HOME=%~dp0
set HOME=%HOME:~,-1%
set DIRS=
for /d %%d in (*) do (
    set name=%%d
    if not "!name:~0,1!" == "." ( 
        if not "%%d" == "htdoc" (
            set DIRS=!DIRS! %%d
        )
    )
)
for %%d in (%DIRS%) do (
    cd %HOME%\%%d
    if exist make.bat (
        make.bat -a 1>nul 2>nul
    )
)
cd %HOME%
