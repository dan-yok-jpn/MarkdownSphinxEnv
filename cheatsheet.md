# Markdown 記法

&emsp;[MyST-Parser](https://myst-parser.readthedocs.io/en/latest/) は [CommonMark](https://commonmark.org/) のスーパー・セットとなっている。 詳細はホームページのサイドメニュー内の [Typography](https://myst-parser.readthedocs.io/en/latest/syntax/typography.html#) 他のコンテンツを参照されたい。<br>
&emsp;なお、web ブラウザに `Markdown Viewer` を[インストール](https://chromewebstore.google.com/detail/markdown-viewer/ckkdlimhmcjmikdlpkmbgfkaikojcbjk?hl=ja&pli=1)すると、 拡張子 .md のファイルのアイコンを右クリックして「プログラムから開く」、 続けて web ブラウザを選択すると画面に整形された文書が表示される。
ヴューアーで[数式](#数式)を表示する場合はこのアドインの設定を[変更](https://qiita.com/XPT60/items/c0609f58d957e438da9d#chrome-%E3%81%AE-markdown-viewer)する必要がある。

## CommonMark

&emsp;CommonMark のフル・スペックは https://spec.commonmark.org/ に掲載されている。<br>
&emsp;基本的な記法について示すと以下のようである。
ただし、CommonMark に定義されていないテーブル（表）については
[Github での記法](https://github.github.com/gfm/#tables-extension-)を示した。<br>

<table>
    <thead>
        <tr>
            <th>Markdown</th>
            <th>表&emsp;示</th>
        </tr>
    </thead>
    <tbody>
        <tr>                        
            <td>*Italic*</td>
            <td><em>Italic</em></td>
        </tr>
        <tr>                        
            <td>**Bold**</td>
            <td><strong>Bold</strong></td>
        </tr>
        <tr>
            <td>
                # Heading 1
            </td>
            <td>
                <h1>Heading 1</h1>
            </td>
        </tr>
        <tr>
            <td>
                ## Heading 2
            </td>
            <td>
                <h2>Heading 2</h2>
            </td>
        </tr>
        <tr>                        
            <td>
                [Link](http://a.com)
            </td>
            <td><a href="https://commonmark.org/">Link</a></td>
        </tr>
        <tr>
            <td>
                ![Image](http://url/a.png)
            </td>
            <td>
                <img src="https://commonmark.org/help/images/favicon.png" width="36" height="36" alt="Markdown"/>
            </td>
        </tr>
        <tr>
            <td>
                &gt; Blockquote
            </td>
            <td>
                <blockquote>Blockquote</blockquote>
            </td>
        </tr>
        <tr>
            <td>
                <p>
                    * List<br/>
                    * List<br/>
                    * List
                </p>
            </td>
            <td>
                <ul>
                    <li>List</li>
                    <li>List</li>
                    <li>List</li>
                </ul>
            </td>
        </tr>
        <tr>
            <td>
                <p>
                    1. One<br/>
                    2. Two<br/>
                    3. Three
                </p>
            </td>
            <td>
                <ol>
                    <li>One</li>
                    <li>Two</li>
                    <li>Three</li>
                </ol>
            </td>
        </tr>
        <tr>
            <td>
                Horizontal rule:<br/>
                <br/>
                ---
            </td>
            <td>
                Horizontal rule:
                <hr />
            </td>
        </tr>
        <tr>                        
            <td>
                `Inline code` with backticks
            </td>
            <td>
                <code>Inline code</code> with backticks
            </td>
        </tr>
        <tr>
            <td>
                ```python<br/>
                from a import b<br/>
                c = "string"<br/>
                ```
            </td>
            <td>
                <div>
                    <span style="color:blue">from</span> a <span style="color:blue">import</span> b<br/>
                    c = <span style="color:green">"string"</span>
                </div>
            </td>
        </tr>
            <td>
                | foo | bar |<br/>
                | --- | --- |<br/>
                | baz | bim |
            </td>
            <td><br>
                <table>
                    <thead><tr><th>foo</th><th>bar</th></tr></thead>
                    <tbody><tr><td>baz</td><td>bim</td></tr></tbody>
                </table>
            </td>
        </tr>
    </tbody>
</table>

## [数 式](https://myst-parser.readthedocs.io/en/latest/syntax/math.html#)

&emsp;`mkProj.bat` で生成する `conf.py` には MyST の[拡張](https://myst-parser.readthedocs.io/en/latest/syntax/optional.html)のうち `dollarmath` と `amsmath` を組み込んでいる。<br>
&emsp;これにより、`$y = a x + b$` はインラインで $y = a x + b$ と表示され、次のマークアップ

```
$$
y = a x + b
$$
```

は別行立てで

$$
y = a x + b
$$

と表示される。あるいは amsmath の[数式環境](https://qiita.com/t_kemmochi/items/a4c390b4967b13f3afb7)

```
\begin{align}
y &= a x + b \\
z &= c x + d
\end{align}
```

を用いて以下のような出力を得ることができる。

$$
y = a x + b
$$
$$
z = c x + d
$$