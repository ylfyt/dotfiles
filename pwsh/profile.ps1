$PSStyle.FileInfo.Directory = ""

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
