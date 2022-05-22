Clear-Host

Import-Module oh-my-posh
Import-Module Terminal-Icons

$theme = "mytheme.omp.json"
$avd1 = "Pixel_4_XL_API_31"
$stem = '/storage/6BDA-99FE/'
$stim = '/storage/emulated/0/'
$ivim = "$env:USERPROFILE\AppData\Local\nvim\init.vim"
$theme_path = "$env:USERPROFILE\dotfiles\pwsh\$theme"
$settings = "$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$dotfiles = "$env:USERPROFILE\dotfiles\"

Set-Alias j z
Set-Alias vi nvim
Set-Alias l ls
Set-Alias g git
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias vs "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe"
Set-Alias emulator "$env:USERPROFILE\AppData\Local\Android\Sdk\emulator\emulator.exe"

Import-Module Posh-Git

# Oh my Posh
oh-my-posh init pwsh --config $theme_path | Invoke-Expression

# Fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# PSReadLine
Set-PSReadLineOption -BellStyle None
# Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Color @{ Parameter = '#E84855' }
Set-PSReadLineOption -Colors @{ Operator = 'Red' }

# List Directory using less
function ll($path){
	ls $path | less -R
}

function ex{
	explorer .
}

# NPM UTILITY
function nr ($cmd){
	npm run $cmd
}

function nrw (){
	npm run watch
}

function nrd (){
	npm run dev
}

 function nrs (){
	npm run start
}

# Switch window theme light and dark (1 for light and 0 for dark)
function light($mode = 1){
	Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value $mode
}

# List directory with filter
function lf($f, $p){
	Get-ChildItem -Path $p -Filter *$f*
}

# List directory with filter and recursively
function lfr($f, $e){
	if ($e -eq $null){
		Get-ChildItem -Exclude node_modules | Get-ChildItem -r -Filter *$f*
	}
	else
	{
		Get-ChildItem -Exclude *$e* | Get-ChildItem -r -Filter *$f*
	}
}

# List directory only name
function ld($p){
	ls -Name $p
}

# Open WSL in Home Directory
function ws(){
	wsl ~
}

# Which command utility
function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Open Android Virtual Device
function avd($name = $avd1){
	emulator -avd $name
}

# WINDOWS TERMINAL UTILITY
# Split horizontal
function sdh{
	wt -w 0 sp -H -d .
}

# Split horizontal
function sd{
	sdh
}

# Split vertical
function sdv{
	wt -w 0 sp -V -d .
}

# Split horizontal then split vertical
function sd2{
	sdh
	sdv
}

# Reload window
function rw {
	wt -w 0 nt -d .
	Start-Sleep -s 1
	exit
}

# New Tab
function nt {
	wt -w 0 nt -d .
}


# GIT UTILITY
# Git log graph
function gg{
    git log --oneline --graph --decorate --all
}

# Git status
function gs{
    git status
}

# Git diff with param
function gd($param){
    git diff $param
}

# Goto projects directory: Change it
function cdp($p){
    Set-Location -Path "D:\projects\$p"
}

# Using Scrcpy : https://github.com/Genymobile/scrcpy
function rsa($ip){
	if ($ip -eq $null){
		scrcpy --max-size 1024 --bit-rate 2M --shortcut-mod=rctrl --power-off-on-close --show-touches --turn-screen-off	
	}
	else {
		scrcpy -s $ip --max-size 1024 --bit-rate 2M --shortcut-mod=rctrl --power-off-on-close --show-touches --turn-screen-off
	}
	#
}

function rsat(){
        scrcpy --max-size 1024 --bit-rate 2M --shortcut-mod=rctrl --power-off-on-close --show-touches --turn-screen-off --always-on-top
}


