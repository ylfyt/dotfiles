Clear-Host
$PSStyle.FileInfo.Directory = ""

oh-my-posh init pwsh --config $HOME\dotfiles\pwsh\mytheme.omp.json | Invoke-Expression

# Fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Color @{ Parameter = '#E84855' }
Set-PSReadLineOption -Colors @{ Operator = 'Red' }

Set-Alias j z
Set-Alias l ls
Set-Alias g git

function which {
    param(
        [string]$CommandName
    )
    $commandInfo = Get-Command -Name $CommandName -ErrorAction SilentlyContinue
    if ($commandInfo.CommandType -eq "Alias") {
        return $commandInfo.DisplayName
    }
    if ($commandInfo.Path -ne $null) {
        return $commandInfo.Path
    }
    $commandPath = Get-Command $CommandName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Definition
    if ($commandPath -ne $null) {
        return $commandPath
    }
    return $null
}

function gg {
    [CmdletBinding()]
    param(
        [switch]$d,
        [switch]$a,
        [switch]$da,
        [switch]$ad
    )

    $format = "{d}%C(auto)%h %C(reset)%C(auto)%d%C(reset)%C(white)%s%C(reset){a}"

    if ($d -or $da -or $ad) {
        $dateCode = "%C(bold blue)%as%C(reset) "
        $format = $format -replace "{d}", $dateCode
    }
    if ($a -or $da -or $ad) {
        $authorCode = '%C(bold green) %an%C(reset)'
        $format = $format -replace "{a}", $authorCode
    }
    $format = $format -replace '{[^}]*}', ''
    git log --graph --abbrev-commit --decorate --format=format:"$format" --all
}

function gs{
    git status
}

function gd($param){
    git diff $param
}
