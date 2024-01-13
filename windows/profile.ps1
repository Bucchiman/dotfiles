echo 8ucchiman
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

fnm env --use-on-cd | Out-String | Invoke-Expression

oh-my-posh init pwsh | Invoke-Expression
