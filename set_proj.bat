@echo off
setlocal

set BIN=%~dp0.venv\Lib\site-packages\bin

if "%1" == "" (
    set PRJ=.
) else (
    set PRJ=%1
)
set SRC=%PRJ%\source

%BIN%\sphinx-quickstart ^
    --sep --ext-mathjax ^
    --no-batchfile --no-makefile  ^
    --project      "project name" ^
    --author       "author names" ^
    --release      "1.0" ^
    --language     "jp" ^
    --extensions   "myst_parser" ^
    --suffix       ".md" ^
    %PRJ%

call :make    >  %PRJ%\make.bat
call :append  >> %SRC%\conf.py
call :index   >  %SRC%\index.md
call :chapter >  %SRC%\renameMe.md

exit /b 0

:make
    echo %BIN%\sphinx-build -M html source build
    exit /b

:append
    echo import sphinx_rtd_theme
    echo html_theme = "sphinx_rtd_theme"
    echo html_theme_path = [sphinx_rtd_theme.get_html_theme_path()]
    echo # html_show_sourcelink = False
    exit /b

:index
	echo # Table of Contents
	echo ```{toctree}
	echo ---
	echo maxdepth: 2
	echo ---
	echo renameMe.md
	echo ```
	echo * [Index](genindex)
	echo * [Search](search)
    exit /b

:chapter
	echo # Chapter
	echo ## Section
    echo ### Subsection
    exit /b
