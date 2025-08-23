@echo off
setlocal

if "%1" == ""   ( goto :help )
if "%1" == "-h" ( goto :help )

if exist %1 (
    echo Project "%1" exists alreadey.
    goto :eof
) else if     "%1" == "-t"  ( set PRJ=TOC
) else if not "%1" == "TOC" ( set PRJ=%1
) else (
    echo "TOC" is reserved. Please change the name.
    goto :eof 
)
mkdir %PRJ%

set SRC=%PRJ%\source

sphinx-quickstart ^
    --quiet --sep ^
    --no-batchfile --no-makefile  ^
    --project      "%PRJ%" ^
    --author       "author names" ^
     -v            "1.0" ^
    --release      "0" ^
    --language     "jp" ^
    --extensions   "myst_parser,sphinx.ext.mathjax,sphinx.ext.autodoc,sphinx.ext.napoleon,sphinx_copybutton" ^
    --suffix       ".md" ^
    %PRJ% 1>nul 2>nul

mkdir %SRC%\_images
call :make    > %PRJ%\make.bat
call :append >> %SRC%\conf.py
if "%PRJ%" == "TOC" ( powershell -Command .\toc %SRC%\index.md
) else              ( call :index > %SRC%\index.md )

goto :eof

:make
    echo @echo off
    echo setlocal
    echo sphinx-build -b html source build %%*
    echo if exist build (
    echo     if not exist build\css\custom.css (
    echo         copy ..\custom.css build\_static\css 1^>nul 2^>nul
    echo     )
    echo )
    exit /b

:append
    echo import sphinx_rtd_theme
    echo html_theme = "sphinx_rtd_theme"
    echo html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
    echo # html_show_sourcelink = False
    echo myst_enable_extensions = ["dollarmath", "amsmath"]
    echo # import os, sys
    echo # path to source code
    echo # sys.path.insert(0, os.path.abspath('../'))
    echo def setup(app):
    echo     app.add_css_file('css/custom.css')
    exit /b

:index
    echo # Table of Contents
    echo ```{toctree}
    echo ---
    echo maxdepth: 3
    echo ---
    echo ***.md
    echo ```
    echo * [Index](genindex)
    echo * [Search](search)
    exit /b

:help
    echo Usage : %~n0 [-h] [-t] [name]
    echo Make a new project for Sphinx document.
    echo.
    echo   -h   : show this help
    echo   -t   : create project named TOC
    echo   name : name of project
    goto :eof