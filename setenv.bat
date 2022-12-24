@echo off
setlocal

set PYTHONHOME=C:\Users\dan_y\AppData\Local\Programs\Python\Python310
set PYTHONPATH=%PYTHONHOME%\Lib;%PYTHONHOME%\Lib\site-packages;

if not exist %PYTHONHOME% (
    echo.
    echo    ERROR !   %PYTHONHOME% not found.
    echo    Check this Scripts
    echo.
    exit /b 0
)

if not exist Lib (
    %PYTHONHOME%\Scripts\pip install ^
        -r requirements.txt -t .\Lib 1>nul 2>&1
)

if "%1" == "" (
    set PRJ=myProject
) else (
    set PRJ=%1
)

set PYTHONPATH=%PYTHONPATH%;%~dp0Lib
set BIN=%~dp0Lib\bin
set SRC=%PRJ%\source

%BIN%\sphinx-quickstart ^
    --quiet --sep --ext-mathjax   ^
    --no-batchfile --no-makefile  ^
    --project      "project name" ^
    --author       "author names" ^
     -v            "1.0" ^
    --release      "0" ^
    --language     "jp" ^
    --extensions   "myst_parser" ^
    --suffix       ".md" ^
    %PRJ%

call :make    >  %PRJ%\make.bat
call :append  >> %SRC%\conf.py
call :index   >  %SRC%\index.md
mkdir %SRC%\img
copy readme.md  %SRC%     1>nul 2>&1
copy img        %SRC%\img 1>nul 2>&1

exit /b 0

:make
    echo @echo off
    echo set PYTHONHOME=%PYTHONHOME%
    echo set PYTHONPATH=%PYTHONPATH%
    echo if "%%1" == "" (
    echo     %BIN%\sphinx-build -M html source build
    echo ) else (
    echo    %BIN%\sphinx-build -M %%1 source build
    echo )
    exit /b

:append
    echo import sphinx_rtd_theme
    echo html_theme = "sphinx_rtd_theme"
    echo html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
    echo # html_show_sourcelink = False
    echo myst_enable_extensions = ["dollarmath", "amsmath"]
    exit /b

:index
	echo # Table of Contents
	echo ```{toctree}
	echo ---
	echo maxdepth: 2
	echo ---
	echo readme.md
	echo ```
	echo * [Index](genindex)
	echo * [Search](search)
    exit /b
