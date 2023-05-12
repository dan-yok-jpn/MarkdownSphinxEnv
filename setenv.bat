@echo off
setlocal enabledelayedexpansion

if not defined %PYTHONHOME% (
    if exist %SystemRoot%\py.exe (
        for /f "usebackq tokens=2" %%i in (`py -0p 2^>nul`) do (
            set V=%%~dpi
            set PYTHONHOME=!V:~0,-1!
        )
    ) else (
        echo.
        echo    ERROR ^^!   PYTHONHOME is not defined.
        echo    Check this Script
        echo.
        exit /b 0
    )
)
set PYTHONPATH=%PYTHONHOME%\Lib;%PYTHONHOME%\Lib\site-packages;

if not exist Lib (
    %PYTHONHOME%\Scripts\pip install ^
        -r requirements.txt -t .\Lib 1>nul 2>&1
)

if "%1" == "" (
    set PRJ=sample
) else (
    set PRJ=%1
)

set PYTHONPATH=%PYTHONPATH%;%~dp0Lib
set BIN=%~dp0Lib\bin
set SRC=%PRJ%\source

%BIN%\sphinx-quickstart ^
    --quiet --sep ^
    --no-batchfile --no-makefile  ^
    --project      "project name" ^
    --author       "author names" ^
     -v            "1.0" ^
    --release      "0" ^
    --language     "jp" ^
    --extensions   "myst_parser,sphinx.ext.mathjax,sphinx.ext.autodoc,sphinx.ext.napoleon,sphinx_copybutton" ^
    --suffix       ".md" ^
    %PRJ%

call :make    >  %PRJ%\make.bat
call :append  >> %SRC%\conf.py
call :index   >  %SRC%\index.md
mkdir %SRC%\_images
if "%PRJ%" == "sample" (
    copy readme.md  %SRC%         1>nul 2>&1
    copy _images    %SRC%\_images 1>nul 2>&1
)
goto :eof

:make
    echo @echo off
    echo set PYTHONHOME=%PYTHONHOME%
    echo set PYTHONPATH=%PYTHONPATH%
    echo %BIN%\sphinx-build source build %%*
    exit /b

:append
    echo import sphinx_rtd_theme
    echo html_theme = "sphinx_rtd_theme"
    echo html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
    echo # html_show_sourcelink = False
    echo myst_enable_extensions = ["dollarmath", "amsmath"]
    echo import os, sys
    echo # path to source code
    echo sys.path.insert(0, os.path.abspath('../'))
    exit /b

:index
	echo # Table of Contents
	echo ```{toctree}
	echo ---
	echo maxdepth: 3
	echo ---
	echo readme.md
	echo ```
	echo * [Index](genindex)
	echo * [Search](search)
    exit /b
