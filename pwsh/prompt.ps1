function prompt {
    $ok = $?

    $loc = $PWD.Path
    if ($loc -eq $HOME) {
        $dir = "~"
    } elseif ($loc.StartsWith("$HOME\", [System.StringComparison]::OrdinalIgnoreCase)) {
        $dir = "~" + $loc.Substring($HOME.Length).Replace('\', '/')
    } else {
        $dir = $loc
    }

    $gitInfo = ""
    if ($PWD.Provider.Name -eq 'FileSystem') {
        $check = [System.IO.DirectoryInfo]$PWD.ProviderPath
        $inGit = $false
        while ($null -ne $check) {
            if (Test-Path -LiteralPath (Join-Path $check.FullName '.git')) {
                $inGit = $true
                break
            }
            $check = $check.Parent
        }

        if ($inGit) {
            $lines = @(git status --porcelain -b 2>$null)
            if ($lines.Count -gt 0) {
                $branch = $lines[0] -replace '^##\s+', '' -replace '\.\.\..*$', ''
                if ($branch -match '^No commits yet on (.+)$') {
                    $branch = $Matches[1]
                }

                $staged = 0
                $untracked = 0
                $modified = 0
                $deleted = 0

                for ($i = 1; $i -lt $lines.Count; $i++) {
                    $xy = $lines[$i].Substring(0, 2)
                    if ($xy -eq '??') {
                        $untracked++
                        continue
                    }
                    if ($xy[0] -ne ' ') { $staged++ }
                    if ($xy[1] -eq 'D') { $deleted++ }
                    elseif ($xy[1] -ne ' ') { $modified++ }
                }

                $stats = ""
                if ($staged -gt 0)    { $stats += " `e[32m✓$staged`e[0m" }
                if ($untracked -gt 0) { $stats += " `e[36m+$untracked`e[0m" }
                if ($modified -gt 0)  { $stats += " `e[33m~$modified`e[0m" }
                if ($deleted -gt 0)   { $stats += " `e[31m-$deleted`e[0m" }

                $gitInfo = " `e[35m($branch)$stats`e[0m"
            }
        }
    }

    $prefix = if ($Host.UI.RawUI.CursorPosition.Y -eq $Host.UI.RawUI.WindowPosition.Y) { "" } else { "`n" }
    $arrowColor = if ($ok) { "`e[32m" } else { "`e[31m" }
    return "$prefix`e[36m$dir`e[0m$gitInfo`n$arrowColor❯`e[0m "
}
