#!/bin/zsh
#
# FileName:     etc
# Author:       8ucchiman
# CreatedDate:  2024-01-21 09:43:11
# LastModified: 2024-01-21 09:49:08
# Reference:    8ucchiman.jp
# Description:  ---
#

if [[ -e $HOME/.config/local/local.zsh ]]; then
    export LOCALZSHRC="$HOME/.config/local"
    source $HOME/.config/local/local.zsh
else
    mkdir -p $HOME/.config/local && touch $_/local.zsh
fi

