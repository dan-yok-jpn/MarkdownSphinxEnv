# Sphinx ドキュメントを作成するための環境設定

## 概&emsp;要

&emsp;[Sphinx](https://www.sphinx-doc.org/en/master/#) は
[reStructuredText（reST）](https://ja.wikipedia.org/wiki/ReStructuredText)を
HTML、LaTeX、ePub などに変換するドキュメント・ジェネレータである。<br>
&emsp;reST は複雑なドキュメントを作成するための仕様が確定している反面、
極論すると Sphinx での利用に限定されるため、学習コストがやや高い。
reST 以外の軽量マークアップ言語としては
[Markdown](https://ja.wikipedia.org/wiki/Markdown) があり、
Github、Qiita、StackOverflow など人気の高い web サイトの既定の投稿フォームとなっている。<br>
&emsp;このリポジトリでは
[MyST-Parser](https://myst-parser.readthedocs.io/en/latest/) 
を用いて Markdown で Sphinx ドキュメントを作成するための環境設定を行うためのスクリプト等を提供する。

<div style="margin-left: 2em">
<dl>
<dt><a href="#setenvbat">setenv.bat</a></dt>
<dd>Sphinx ドキュメントを作成するための仮想環境の作成</dd>
<dt><a href="#updatebat">update_env.bat</a></dt>
<dd>仮想環境の再構築・ライブラリの更新</dd>
<dt><a href="#mkprojbat">mkProj.bat</a></dt>
<dd>プロジェクトのファイル・ツリーの初期設定</dd>
<dt><a href="#make_htdocsbat">make_htdocs.bat</a></dt>
<dd>複数のプロジェクトが存在する場合の公開用の Sphinx ドキュメントの作成</dd>
<dt><a href="#make_allbat">make_all.bat</a></dt>
<dd>全プロジェクトの web コンテンツの再生成</dd>
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

&emsp;初回の実行時は `.venv` ディレクトリが作成され、
`resurements.txt` に記述されているサイトパッケージがインストールされる。
また `.vscode` ディレクトリに仮想環境用の設定を加える。

## update_env.bat

**Usage**

```
update_env
```

&emsp;Python がバージョンアップした場合に仮想環境の再構築を行う。
&emsp;また、必要に応じて `shpinx` パッケージおよび `myst_parser` パッケージ等の更新を行う。
さらに、ユーザーが求める場合に Sphinx ドキュメントの再生成を行う。<br>

## mkProj.bat

**Usage**

<pre>
mkProj (<i>project-name</i> | -t | -h)
</pre>

&emsp;*`project-name`* をトップディレクトリとするプロジェクトを作成し、
同ディレクトリに web コンテンツを生成するための `make.bat` を、
サブディレクトリ `source` に `index.md` と `conf.py` のテンプレートを配置する。<br>
&emsp;`-t` オプションは複数のプロジェクトの総目次を表示するためのプロジェクト
`TOC` を作成する。

&emsp;*project-name* の source ディレクトリに
[Markdown 記法](cheatsheet.md)で記述したファイル（拡張子 .md）を追加して
index&#046;md にこれを反映した後、以下を実行すると
`build` ディレクトリに web コンテンツが生成される。

<pre>
cd <i>project-name</i> 
make
build\index.html    # 既定の web ブラウザで Sphinx ドキュメントが表示される
</pre>

## make_htdocs.bat

**Usage**

```
make_htdocs
```

&emsp;`TOC\build` のファイル・ツリーを `htdocs` にコピーするとともに、
`TOP` 以外のプロジェクトの `build` のファイル・ツリー（
全プロジェクト共通の `_static` を除く）をサブディレクトリにコピーする。
この際、*.html 内のハイパーリンクは htdocs のファイル・ツリーと整合するように修正する。

## make_all.bat

**Usage**

```
make_all
```

&emsp;サイトパッケージの再インストールを行った際などに各プロジェクトの
`make.bat` を起動する。
