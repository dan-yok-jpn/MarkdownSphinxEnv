@echo off
setlocal enabledelayedexpansion

if not defined PYTHONHOME (
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
    echo.
    echo    ERROR ^^!   Library not exists.
    echo    Run `./setenv.bat' first.
    echo.
    exit /b 0
)

if "%1" == "" (
    set PRJ=sample_api
) else (
    set PRJ=%1
)

set PYTHONPATH=%PYTHONPATH%;%~dp0Lib
set BIN=Lib\bin
set SRC=%PRJ%\source
set PRG=%PRJ%\programs

if not exist %PRG% (mkdir %PRG%)

%BIN%\sphinx-quickstart ^
    --quiet --sep ^
    --no-batchfile --no-makefile  ^
    --project      "project name" ^
    --author       "author names" ^
     -v            "1.0" ^
    --release      "0" ^
    --language     "jp" ^
    --extensions   "myst_parser,sphinx.ext.mathjax,sphinx.ext.autodoc,sphinx.ext.napoleon,sphinx_copybutton" ^
    %PRJ%

call :make   >  %PRJ%\make.bat
call :make2  >  %PRJ%\make_apidoc.bat
call :append >> %SRC%\conf.py
call :index  >  %SRC%\index.rst

mkdir %SRC%\_images
if "%PRJ%" == "sample_api" (
    copy _images\sample.py  %PRG% 1>nul 2>&1
)
goto :eof

:make
    echo @echo off
    echo set PYTHONHOME=%PYTHONHOME%
    echo set PYTHONPATH=%%PYTHONHOME%%\Lib;%%PYTHONHOME%%\Lib\site-packages;..\Lib;programs
    echo ..\%BIN%\sphinx-build source build %%*
    echo if exist build (
    echo     if not exist build\css\custom.css (
    echo         copy ..\custom.css build\_static\css 1^>nul 2^>nul
    echo     )
    echo )
    exit /b

:make2
    echo @echo off
    echo set PYTHONHOME=%PYTHONHOME%
    echo set PYTHONPATH=%%PYTHONHOME%%\Lib;%%PYTHONHOME%%\Lib\site-packages;..\Lib
    echo ..\%BIN%\sphinx-apidoc programs -o source
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
    echo def setup(app):
    echo     app.add_css_file('css/custom.css')
    exit /b

:index
	echo Welcome to project name's documentation!
	echo ========================================
	echo.
	echo .. toctree::
	echo    :maxdepth: 2
	echo    :caption: Contents
	echo. 
	echo    modules
	echo.
	echo.
	echo Indices and tables
	echo ==================
	echo.
	echo * :ref:`genindex`
	echo * :ref:`modindex`
	echo * :ref:`search`
    exit /b
