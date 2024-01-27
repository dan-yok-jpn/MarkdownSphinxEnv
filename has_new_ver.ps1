function get_new_version ($repo) {

    $url = "https://api.github.com/repos/" + `
                $repo + "/releases/latest"

    Invoke-WebRequest $url |
    ConvertFrom-Json |
    Select-Object tag_name |
    ForEach-Object {
        return $_.tag_name.Replace("v", "")
    }
}

function get_cur_version ($pac) {

    $regex = $pac + ".*.dist-info"

    $names = (
        Get-ChildItem -Path .\Lib -Attributes D |
        Where-Object {$_.Name -Match $regex}
    )
    $name = ($names[$names.Length - 1] | Out-String)

    return $name.Replace("$pac", "").Replace("`.dist-info", "")
}

$new_sphinx = get_new_version("sphinx-doc/sphinx")
$new_myst   = get_new_version("executablebooks/MyST-Parser")
$cur_sphinx = get_cur_version("sphinx-")
$cur_myst   = get_cur_version("myst_parser-")

if (($new_sphinx -gt $cur_sphinx) -or ($new_myst -gt $cur_myst)) {
    $LASTEXITCODE = 1 # has new version
} else {
    $LASTEXITCODE = 0
}
