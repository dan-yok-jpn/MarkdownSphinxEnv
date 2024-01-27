# Sphinx ドキュメントを作成するための環境設定

## 概&emsp;要

&emsp;[Sphinx](https://www.sphinx-doc.org/en/master/#) は
[reStructuredText（reST）](https://ja.wikipedia.org/wiki/ReStructuredText)を
HTML や PDF、EPUB、Texinfo 及び
man ページなどの他のフォーマットに変換するドキュメンテーションジェネレータである。<br>
&emsp;reST は複雑なドキュメントを作成するための仕様が確定しいる反面、
極論すると Sphinx での利用に限定されるため、学習コストがやや高い。
reST 以外の軽量マークアップ言語としては
[Markdown](https://ja.wikipedia.org/wiki/Markdown) があり、
Github、Qiita、StackOverflow など人気の高い web サイトの既定の投稿フォームとなっている。<br>
&emsp;そこで、ここでは Markdown を用いて Sphinx ドキュメントを作成するための
[MyST-Parser](https://myst-parser.readthedocs.io/en/latest/) 
が利用可能な環境設定を行う。
具体的には以下のバッチファイルによってこれを行う。

<div style="margin-left: 2em">
<dl>
<dt><a href="#setenvbat">setenv.bat</a></dt>
<dd>ライブラリのインストール、アップデート</dd>
<dt><a href="#mkprojbat">mkProj.bat</a></dt>
<dd>プロジェクトの基本構成の作成</dd>
<dt><a href="#make_allbat">make_all.bat</a></dt>
<dd>全プロジェクトの web コンテンツの再生成</dd>
<dt><a href="#htdocmakebat">htdoc\make.bat</a></dt>
<dd>複数のプロジェクトが存在する場合の web コンテンツの作成</dd>
</dl>
</div>

## Requirement

* \>= Windows 10
* \>= Python 3.9
* [GNU sed](https://winstall.app/apps/mbuilov.sed)

&emsp;上記のバッチファイル内で `py.exe` あるいは `pip.exe` を呼び出すので、
Python は[公式サイト](https://www.python.org/)からインストールされたものである必要がある。
sed は複数のプロジェクトの総目次を作成する場合に使用する。

## setenv.bat

**Usage**

```
setenv
```

&emsp;初回の実行時は `Lib` ディレクトリが作成され、
`resurements.txt` に記述されているサイトパッケージがインストールされる。
再度実行する場合は `shpinx` パッケージおよび `myst_parser` パッケージの更新状況を確認して、
必要があればサイトパッケージの再インストールを行う。

## mkProj.bat

**Usage**

<pre>
mkProj [<i>project-name</i>] [-t] [-h]
</pre>

&emsp;*`project-name`* をトップディレクトリとするプロジェクトを作成し、
同ディレクトリに web コンテンツを生成するための `make.bat` を、
サブディレクトリ `source` に `index.md` と `conf.py` のテンプレートを配置する。<br>
&emsp;`-t` オプションは複数のプロジェクトの総目次を表示するためのプロジェクト
`TOC` を作成する。<br>
&emsp;`-h` オプションはヘルプを表示する。<br>

## make_all.bat

**Usage**

```
make_all
```

&emsp;サイトパッケージの再インストールを行った際などに各プロジェクトの
`make.bat` を起動する。

## htdoc\make.bat

**Usage**

```
cd htdoc
make
```

&emsp;公開用の Sphinx ドキュメントを作成する。
具体的には、`TOC\build` のファイル・ツリーを `html` にコピーするとともに、
`TOP` 以外のプロジェクトの `build` のファイル・ツリー（
全プロジェクト共通の `_static` を除く）をサブディレクトリにコピーする。
この際、*.html 内のハイパーリンクは新たなファイル・ツリーと整合するように修正する。

## 実際の作業

&emsp;*`project-name`* の
`source` ディレクトリに Markdown 記法で記述したファイル（拡張子 .md）を追加して
`index.md` にこれを反映した後、以下を実行すると `build` ディレクトリに
web コンテンツが生成される。

<pre>
cd <i>project-name</i> 
make
build\index.html    # 既定の web ブラウザで Sphinx ドキュメントが表示される
</pre>
