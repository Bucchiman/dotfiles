#if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) { Start-Process powershell.exe "-File `"$PSCommandPath`"" -Verb RunAs; exit }

#管理者権限で実行したい処理を以下に記述する
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole("Administrators")) 
{
  Start-Process powershell.exe "-ExecutionPolicy RemoteSigned -File `"$PSCommandPath`"" -Verb RunAs
  ;exit
}


#New-Item -ItemType SymbolicLink -Value "$HOME\git\dotfiles\.config\dein" -Name dein -Path "$HOME\AppData\Local\"
#New-Item -Value "$HOME\git\dotfiles\windows\settings.json" -Path "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Name settings.json -ItemType SymbolicLink
#New-Item -Value "$HOME\git\dotfiles\windows\profile.ps1" -Path "$HOME\Documents\WindowsPowerShell" -Name profile.ps1 -ItemType SymbolicLink

#New-Item -Value "C:\Users\bucchiman\git\dotfiles\windows\settings.json" -Path "C:\Users\bucchiman\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Name settings.json -ItemType SymbolicLink

New-Item -Value "C:\Users\bucchiman\git\dotfiles\windows\profile.ps1" -Path "C:\Users\bucchiman\OneDrive\ドキュメント\WindowsPowerShell" -Name profile.ps1 -ItemType SymbolicLink

New-Item -Value "C:\Users\bucchiman\git\dotfiles\.wezterm.lua" -Path "C:\Users\bucchiman" -Name .wezterm.lua -ItemType SymbolicLink

New-Item -Value "C:\Users\bucchiman\git\dotfiles\.config\nvim\init.lua" -Path "C:\Users\bucchiman\AppData\Local\nvim" -Name init.lua -ItemType SymbolicLink

New-Item -Value "C:\Users\bucchiman\git\dotfiles\.config\nvim\lua" -Path "C:\Users\bucchiman\AppData\Local\nvim" -Name lua -ItemType SymbolicLink
#Microsoft.PowerShell_profile.ps1
Start-Sleep -s 10

