#!/bin/zsh
#
# FileName:     aliases
# Author:       8ucchiman
# CreatedDate:  2023-09-08 00:40:43
# LastModified: 2023-01-23 14:11:45 +0900
# Reference:    https://github.com/xero/dotfiles/blob/main/zsh/.config/zsh/06-aliases.zsh
# Description:  ---
#


#set -ex        # 途中のエラーで実行中断

function func_lst () {
    echo "***********************************"
    echo "The following function is prepared."
    echo "***********************************"
    cat $0 | awk '/^function/ {printf "| %s\n", $2}'
    echo "***********************************"
}


########################################
# while getopts :i:c:g OPT
# do
#     case $OPT in
#         i) image_name=$OPTARG;;
#         g) gpu_flag=true;;
#         c) container_name=$OPTARG;;
#         :|\?) _usage;;
#     esac
# done
# function _usage () {
#     echo 
# }
# function help () {
# 
# }
# 
# 
# function main02 () {
#     
# }
########################################

typeset -A SUBMODULES
function set_variables () {
    #
    #
    #
    #
    echo "******************************"
    echo "* set_variables              *"
    echo "******************************"
    BASE_DIR=$PWD
    SUBMODULES=(yolostereo3D https://github.com/Owen-Liuyuxuan/visualDet3D.git)
}


function setup_environment () {
}

function xero_aliases () {
    #
    # https://github.com/xero/dotfiles/blob/main/zsh/.config/zsh/06-aliases.zsh
    #
    alias g="git"
    alias e="$EDITOR"
    alias ec='nvim --cmd ":lua vim.g.noplugins=1" '
    alias g="git"
    alias y="yank"
    alias rmrf="rm -rf"

    # git
    alias ga="git add"
    alias gb="git branch"
    alias gc="git clone"
    alias gcm="git commit -m"
    alias gco="git checkout"
    alias gcob="git checkout -b"
    alias gcs="git commit -S -m"
    alias gd="git difftool"
    alias gdc="git difftool --cached"
    alias gf="git fetch"
    alias gg="git graph"
    alias ggg="git graphgpg"
    alias gm="git merge"
    alias gp="git push"
    alias gpr="gh pr create"
    alias gr="git rebase -i"
    alias gs="git status -sb"
    alias gt="git tag"
    alias gu="git reset @ --"
    alias gx="git reset --hard @"
}



function default () {
    #
    # this is default setting
    # you can run this function without no arguments.
    #
    echo "******************************"
    echo "* default                    *"
    echo "******************************"
    echo "this is default setting"
    echo "you can run this function without no arguments."

}


#######################################
function main01 () {
    set_variables
    if [[ $@ == "" ]]; then
        default
    else
        eval $@
    fi

}

ME=$0
main01 $@
#######################################


return

