Clear-Host
# Remove background color on directory when ls / Get-ChildItem
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

Invoke-Expression (& { (zoxide init --cmd j powershell | Out-String) })

Set-Alias cd j -Option AllScope
Set-Alias cdi ji -Option AllScope
Set-Alias g git

# Replace ls with eza
try { Remove-Alias ls -ErrorAction Stop } catch {}
function ls { eza --icons --color=always --group-directories-first -l $args }
function ll { eza --icons --color=always --group-directories-first -alF $args }
function l  { eza --icons --color=always --group-directories-first -alF -snew $args }
function l. { eza -a | egrep "^\." $args }

function gs { git status }
function gd { git diff $args }

try { Remove-Alias pwd -ErrorAction Stop } catch {}
function pwd { (Get-Location).Path }

$env:JAVA_HOME = "$HOME\jdk"
$env:ANDROID_HOME = "$HOME\AppData\Local\Android\Sdk"

$env:PATH += ";$HOME\cool-bin;"
$env:PATH += "C:\Program Files\Go\bin;"
$env:PATH += "$(go env GOPATH)\bin;"
$env:PATH += "$HOME\flutter\bin;"
$env:PATH += "$env:JAVA_HOME\bin;"
$env:PATH += "$env:ANDROID_HOME\tools;"

function which {
    param(
        [string]$cmdName
    )
    $cmdInfo = Get-Command -Name $cmdName -ErrorAction SilentlyContinue
    if ($cmdInfo.CommandType -eq "Alias") {
        return $cmdInfo.DisplayName
    }
    if ($cmdInfo.Path -ne $null) {
        return $cmdInfo.Path
    }
    $cmdPath = Get-Command $cmdName -ErrorAction SilentlyContinue | Select-Object -ExpandProperty Definition
    if ($cmdPath -ne $null) {
        return $cmdPath
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
