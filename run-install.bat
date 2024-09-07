scoop install fzf eza

Install-Module posh-git -Scope CurrentUser -Force
winget install JanDeDobbeleer.OhMyPosh -s winget

Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
Install-Module -Name PSFzf -Scope CurrentUser -Force
Install-Module -Name z -Force