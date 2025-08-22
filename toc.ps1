# https://note.com/1in9mu/n/n6663c74258a3

$fmt = '* <a href="../../{0}/build/index.html">{1}</a>'
$lines = @('# Table of contents', '')
Get-ChildItem -Path . -Attributes D |
Where-Object {$_.Name -ne "TOC" -and $_.Name -ne "htdoc" `
         -and (-not ($_.Name.StartsWith(".")))} |
ForEach-Object {
    $proj = $_.Name
    $conf = $proj + "\source\conf.py"
    Select-String -Path $conf -Pattern "^project" |
    ForEach-Object {
        $ttl = $_.Line.split("'")[1]
        $lines += $fmt -f $proj, $ttl
    }
}

$enc = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($args[0], $lines, $enc)
