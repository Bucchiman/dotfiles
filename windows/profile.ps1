

echo 8ucchiman
Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteChar

#Set-Alias -Name settings -Value "C:\Users\yk.iwabuchi\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
Set-Alias -Name settings -Value "C:\Users\8ucch\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# New-Item -Value '(リンク先フォルダ)' -Path '(シンボリックリンクの配置先)' -Name (シンボリックリンク名) -ItemType SymbolicLink
# New-Item -Value '$HOME\git\dotfiles\windows\profile.ps1' -Path '$HOME\Documents\WindowsPowerShell' -Name profile.ps1 -ItemType SymbolicLink

$USER_NAME = $env:USERNAME
$WSL_HOME = "Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu\home\" + $USER_NAME
Invoke-Expression (&starship init powershell)

$ENV:Path=$HOME+"\bin;"+$ENV:Path

Set-PSReadLineKeyHandler -Chord Ctrl+o -ScriptBlock {
    $selected = fzf
    if ($selected) {
        [System.Windows.Forms.SendKeys]::SendWait("$selected ")
    }
}


$env:Path = "C:\Users\8ucch\.local\bin;$env:Path"
$env:PSModulePath += ";C:\Program Files\PowerShell\7\Modules"


function gs() {
    git status -s
}

function ga() {
    git add $args
}

function gco() {
    git checkout $args
}

function gcod() {
    git checkout dev
}

function gcob() {
    git checkout -b $args
}

function gcm() {
    git commit -m $args
}

function gf() {
    git fetch
}

function gm() {
    git merge
}

function gfom() {
    git fetch origin main
}

function gfod() {
    git fetch origin dev
}

function gmom() {
    git merge origin/main
}

function gmod() {
    git merge origin/dev
}


function gba() {
    git branch -a
}

# auto cd
# Install-Module -Name cd-extras -RequiredVersion 2.9.4
# https://www.powershellgallery.com/packages/cd-extras/2.9.4
Import-Module cd-extras

