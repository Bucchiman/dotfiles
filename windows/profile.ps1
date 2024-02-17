#!/usr/bin/env pwsh
#
# FileName:     profile
# Author:       8ucchiman
# CreatedDate:  2023-01-15 09:49:00
# LastModified: 2024-01-19 12:33:21
# Reference:    8ucchiman.jp
# Description:  ---
#


# Write-Output 8ucchiman
Import-Module PSReadLine
Set-PSReadlineOption -EditMode Emacs
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteChar

Set-Alias -Name settings -Value "C:\Users\yk.iwabuchi\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# New-Item -Value '(リンク先フォルダ)' -Path '(シンボリックリンクの配置先)' -Name (シンボリックリンク名) -ItemType SymbolicLink
# New-Item -Value '$HOME\git\dotfiles\windows\profile.ps1' -Path '$HOME\Documents\WindowsPowerShell' -Name profile.ps1 -ItemType SymbolicLink

$USER_NAME = $env:USERNAME
# $USER_NAME = "ykiwabuchi"
$WSL_HOME = "Microsoft.PowerShell.Core\FileSystem::\\wsl$\Ubuntu\home\" + $USER_NAME

Set-Item Env:Path "$HOME\AppData\Local\Microsoft\WinGet\Packages\junegunn.fzf_Microsoft.Winget.Source_8wekyb3d8bbwe;$ENV:Path"


# oh-my-posh init pwsh | Invoke-Expression

# function fzf_key () {
#     Write-Output "hello keymap"
# }
# 
# Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function fzf_key

# reference> https://qiita.com/AWtnb/items/0bfd10b9e430759d17a4
#Set-PSReadlineKeyHandler -Chord Ctrl+u `
#                         -BriefDescription ParentDirectory `
#                         -LongDescription "Push parent directory" `
#                         -ScriptBlock {
#    # Write-Output "Hello world from 8ucchiman"
#    $command = fzf
#    [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
#}

Import-Module PSFzf
Enable-PsFzfAliases
Import-Module ZLocation


$ENV:Path="C:\msys64\mingw64\bin;"+$ENV:Path
$ENV:Path="$HOME\.cargo\bin;"+$ENV:Path

fnm.exe env --use-on-cd | Out-String | Invoke-Expression

# Set-PSReadLineKeyHandler -Key "Ctrl+f" -BriefDescription "fzf" -LongDescription "cmdlet-search-by-fzf" -ScriptBlock {
#     $command = Write-Output "cd $HOME/dotfiles/windows/onelines; fzf"
#     [Microsoft.PowerShell.PSConsoleReadLine]::Insert($command)
# }


