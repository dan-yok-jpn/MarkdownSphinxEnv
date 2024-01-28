@echo off
setlocal enabledelayedexpansion

if not exist TOC (
    echo No need to make hdocs.
    goto :eof
)

for /f "usebackq" %%p in (`where /f sed 2^>nul`) do (
    set SED=%%p
)
if "%SED%" == "" (
    echo sed.exe not found.
    goto :eof 
)

if exist htdocs (
    call :get_time htdocs
    set tm0=%tm%
) else (
    mkdir htdocs
    set tm0=
) 

for /d %%d in (*) do (
    if not "%%d" == "Lib" (
        if not "%%d" == "htdocs" (
            call :get_time %%d\build
            if "!tm!" gtr "%tm0%" ( set PRJS=!PRJS! %%~nd ) 
        )
    )
)
if "PRJS" == "" (
    echo Nothing to do.
    goto :eof
)

echo Update %PRJS% 

set META=meta http-equiv=\"Content-type\"
set META=%META% content=\"text\/html; charset=utf-8\" \/

for %%i in (%PRJS%) do (

    set SRC=%%i\build
    if "%%i" == "TOC" (
        set DST=htdocs
        xcopy /s /i /y !SRC!\_static !DST!\_static 1>nul 2>nul
    ) else (
        set DST=htdocs\%%i
        if not exist !DST! ( mkdir !DST! )
    )

    xcopy /s /i /y !SRC!\.doctrees !DST!\.doctrees   1>nul 2>nul
    xcopy /s /i /y !SRC!\_images   !DST!\_images     1>nul 2>nul
    xcopy /s /i /y !SRC!\_sources  !DST!\_sources    1>nul 2>nul
    if exist !SRC!\*.js  ( copy /y !SRC!\*.js  !DST! 1>nul 2>nul )
    if exist !SRC!\*.inv ( copy /y !SRC!\*.inv !DST! 1>nul 2>nul )

    for %%j in (!SRC!\*.html) do (
        if "%%i" == "TOC" (
            xcopy /s /i /y !SRC!\_static !DST!\_static 1>nul 2>nul
            %SED% -e "s/\.\.\/\.\.\///" ^
                  -e "s/build\///" ^
                  -e "s/.meta charset=.*$/<%META%>/" ^
                  %%j > !DST!\%%~nxj

        ) else (
            %SED% -e "s/_static/..\/_static/" ^
                  -e "s/build\///" ^
                  -e "s/.meta charset=.*$/<%META%>/" ^
                  %%j > !DST!\%%~nxj
        )
    )
)
goto :eof

:get_time %1
    for %%i in (%1) do ( set tm=%%~ti )
    exit /b
