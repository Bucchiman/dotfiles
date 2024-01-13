#!/usr/bin/env pwsh
#
# FileName:     Bmods
# Author:       8ucchiman
# CreatedDate:  2024-01-13 14:48:33
# LastModified: 2024-01-13 16:22:54
# Reference:    https://www.ipentec.com/document/powershell-create-function
# Description:  powershell用のBmods
#



function __init () {
    #
    # @Description  initialize Bmods et al
    # @params       
    # @Example      __init
    # @Reference    
    #

    New-Item -Value $HOME/dotfiles/windows/Bmods.ps1 -Path $HOME -Name Bmods.ps1 -ItemType SymbolicLink
}

function __hello () {
    Write-Output "hello world"      # echo
}

function install_fzf () {
    Install-Module -Name PSFzf -scope currentUser
    Install-Module -Nmae ZLocation -scope currentUser
}

function import_fzf () {
    Import-Module PSFzf
    Enable-PsFzfAliases
    Import-Module ZLocation
}

function onelines_fzf () {
    Set-Location $HOME/dotfiles/windows/onelines      # alternative to cd
    fzf
}

function ln ($from_file, $to_path) {
    #
    # @Description  symblic link
    # @params       $from_file: original file (e.g $HOME/dotfiles/windows/Bmods.ps1)
    #               $to_path: path to make symbolic link (e.g. $HOME)
    # @Example      ln $HOME/dotfiles/windows/Bmods.ps1 $HOME
    # @Reference    https://qiita.com/tokky_se/items/128a04e861b2863e2c99
    #

    $filename = (Get-Item $from_file).Name
    New-Item -Value $from_file -Path $to_path -Name $filename -ItemType SymbolicLink

}

function what_file_is_this ($file_path) {
    #
    # @Description  file infomation
    # @params       $file_path: file path
    # @Example      what_file_is_this $PWD/Bmods.ps1
    # @Reference    https://stackoverflow.com/questions/12503871/removing-path-and-extension-from-filename-in-powershell
    #

    Write-Output $file_path                # alternative to echo 
    (Get-Item $file_path ).Extension       ## .ps1
    (Get-Item $file_path ).Basename        ## Bmods
    (Get-Item $file_path ).Name            ## Bmods.ps1
    (Get-Item $file_path ).DirectoryName   ## C:\Users\Bucchiman\dotfiles\windows
    (Get-Item $file_path ).FullName        ## C:\Users\Bucchiman\dotfiles\windows\Bmods.ps1

    #$ConfigINI = (Get-Item $PSCommandPath ).DirectoryName+"\"+(Get-Item $PSCommandPath ).BaseName+".ini"
}



# onelines_fzf
# ln /tmp/hello.ps1 $HOME
# what_file_is_this $HOME/.config/sample/pics/lena.jpg

# Reference: https://microsoftou.com/ps-arguments/
#Write-Host $Args[0]

# Reference: https://devblogs.microsoft.com/scripting/powertip-list-all-parameters-for-a-cmdlet/
# (GET-Command GET-Childitem).parameters

Invoke-Expression $Args[0]
