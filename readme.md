# MarkdownSphinxEnv

Set environment to create Sphinx Document using [MyST (Markedly Structured Text)](https://myst-parser.readthedocs.io/en/latest/).

## Reuirement

* windows
* python3

## Preparement

Modify the 4th line of `setenv.bat` according your PC's setting.
You can confirm this path with run `py -0p`.

```cmd
set PYTHONHOME=C:\Python\Python310
```

## setenv.bat

The command `setenv.bat` create new directory `Lib` and `myProject` as below.
`Lib` is libraries to build Sphinx Document.
`myProject` is temporary, so you can reneme as you like.

```cmd
setenv
```

```cmd
.
|   .gitignore
|   readme.md
|   requirements.txt
|   setenv.bat
|   sphinx.PNG
+---.git\
+---Lib\
|   +---bin\
|   |       sphinx-quickstart.exe
|   |       sphinx-build.exe
|   |       the other modules
|   +---sphinx\
|   +---sphinx_rtd_theme\
|   +---myst_parser\
|   \---the other libralies\
\---myProject\
    |   make.bat
    +---build\
    \---source\
        |   conf.py
        |   index.md
        |   renameMe.md
        +---_static\
        \---_templates\
```

## Make HTML Shinx Document

If you type as below before edit files in `myProject\source\`,
Web contents shown below are created at `myProject\build\html\`. 

```cmd
cd myProject
make
```

![](sphinx.PNG)

###  PROJECT_HOME\souce\conf.py

Edit the 9-12th lines according to your project.

```Python
project = 'project name'
copyright = '2022, author names'
author = 'author names'
release = '1.0'
```

###  PROJECT_HOME\souce\index.md

The `index.md` describe table of contents.
Below sample shows in case consists 3 chapters.
`chapter_[1-3].md` follows [MyST's core syntax](https://myst-parser.readthedocs.io/en/latest/syntax/syntax.html#) and [syntx extension](https://myst-parser.readthedocs.io/en/latest/syntax/optional.html).

````md
# Table of Contents
```{toctree}
---
maxdepth: 2
---
chapter_1.md
chapter_2.md
chapter_3.md
```
* [Index](genindex)
* [Search](search)
````

### LaTex

```md
**Reynolds equations**

$$
\frac{\partial{u}_i}{\partial t}
     + \frac{\partial\bigl({u}_i u_j\bigr)}{\partial x_j}
    = X_i - \frac{1}{\rho}\frac{\partial{p}}{\partial x_i}
     + \frac{\partial}{\partial x_j}\! \left(
        \nu \frac{\partial{u}_i}{\partial x_j}
      \right)
$$

Where, $t$ : time, $x_i$ : space, $u_i$ : velocity, 
$X_i$ : external force, $\rho$ : density, $\nu$ : kinematic viscosity.
```

**Reynolds equations**

$$
\frac{\partial{u}_i}{\partial t}
     + \frac{\partial\bigl({u}_i u_j\bigr)}{\partial x_j}
    = X_i - \frac{1}{\rho}\frac{\partial{p}}{\partial x_i}
     + \frac{\partial}{\partial x_j}\left(
        \nu \frac{\partial{u}_i}{\partial x_j}
      \right)
$$

Where, $t$ : time, $x_i$ : space, $u_i$ : velocity, 
$X_i$ : external force, $\rho$ : density, $\nu$ : kinematic viscosity.

