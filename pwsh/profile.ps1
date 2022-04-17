Clear-Host

Import-Module Posh-Git
Import-Module oh-my-posh
Import-Module Terminal-Icons

$omp_config = Join-Path $PSScriptRoot "./mytheme.omp.json"
# oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

Set-Alias j z
Set-Alias vi nvim
Set-Alias l ls
Set-Alias g git
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

function ll($path){
	ls $path | less -R
}

$themes = 'C:\Program Files\WindowsPowerShell\Modules\oh-my-posh\3.175.0\themes'
$ivim = 'C:\Users\Yudi\AppData\Local\nvim\init.vim'
$settings = 'C:\Users\Yudi\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
$stim = '/storage/emulated/0/'
$stem = '/storage/6BDA-99FE/'

# Fzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# PSReadLine
Set-PSReadLineOption -BellStyle None
# Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -Color @{ Parameter = '#E84855' }
Set-PSReadLineOption -Colors @{ Operator = 'Red' }

function ex{
	explorer .
}

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

function light($mode = 1){
	Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value $mode
}

function lf($f, $p){
	Get-ChildItem -Path $p -Filter *$f*
}

function lfr($f, $e){
	if ($e -eq $null){
		Get-ChildItem -Exclude node_modules | Get-ChildItem -r -Filter *$f*
	}
	else
	{
		Get-ChildItem -Exclude *$e* | Get-ChildItem -r -Filter *$f*
	}
}

function ld($p){
	ls -Name $p
}

function ws(){
	wsl ~
}

function which ($command) {
  Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

$avd1 = "Pixel_4_XL_API_31"
Set-Alias vs "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe"
Set-Alias emulator C:\Users\Yudi\AppData\Local\Android\Sdk\emulator\emulator.exe

function avd($name = $avd1){
	emulator -avd $name
}

function sdh{
	wt -w 0 sp -H -d .
}

function sd{
	sdh
}

function sdv{
	wt -w 0 sp -V -d .
}

function sd2{
	sdh
	sdv
}

function rw {
	wt -w 0 nt -d .
	Start-Sleep -s 1
	exit
}

function nt {
	wt -w 0 nt -d .
}


function gg{
    git log --oneline --graph --decorate --all
}

function gs{
    git status
}

function gd($param){
    git diff $param
}

function cdp($p){
    Set-Location -Path "D:\projects\$p"
}

function getip(){
	# Get Ip Address
	[string]$var = adb shell ifconfig
	[string]$temp = $var.Split(" ") | Select-String "addr:192."
	[string]$ip = $temp.Split(":")[1]
	return $ip 
}

function adw(){	
	adb kill-server	
	adb tcpip 5555
	Start-Sleep -s 2	
	$ip = getip
	adb connect $ip
}

function getAllDeviceId(){
	[string]$var = adb devices
	$other = ($var  |  Select-String -Pattern "\d{1,3}(\.\d{1,3}){3}" -AllMatches).Matches.Value
	
	return $other
}

function rsa($idx){
	# echo $ip.GetType()
	if ($idx -eq $null){
		scrcpy --max-size 1024 --bit-rate 2M --shortcut-mod=rctrl --power-off-on-close --show-touches --turn-screen-off	
	}
	else {
		$ids = getAllDeviceId
		$ip = $ids[$idx-1]

		if ($ip -eq $null){
			$ip = $ids[0]
		}
		echo ("Connect to " + $ip)
		scrcpy -s $ip --max-size 1024 --bit-rate 2M --shortcut-mod=rctrl --power-off-on-close --show-touches --turn-screen-off
	}
	#
}

function rsat(){
        scrcpy --max-size 1024 --bit-rate 2M --shortcut-mod=rctrl --power-off-on-close --show-touches --turn-screen-off --always-on-top
}

function sshr($ip){
	# 192.168.1.14
	echo 'Connecting to redmi 4 via ssh'
	ssh u0_a156@$ip -p 8022
}

function sshm($ip){
	# 192.168.1.19
	echo 'Connecting to max pro m1 via ssh'
	ssh u0_a237@$ip -p 8022
}

function Get-Temperature {
    $t = Get-WmiObject MSAcpi_ThermalZoneTemperature -Namespace "root/wmi"
    $returntemp = @()

    foreach ($temp in $t.CurrentTemperature)
    {


    $currentTempKelvin = $temp / 10
    $currentTempCelsius = $currentTempKelvin - 273.15

    $currentTempFahrenheit = (9/5) * $currentTempCelsius + 32

    $returntemp += $currentTempCelsius.ToString() + " C : " + $currentTempFahrenheit.ToString() + " F : " + $currentTempKelvin + "K"  
    }
    return $returntemp
}

