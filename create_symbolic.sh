#!/bin/zsh
#
# FileName: 	create_symbolic.sh
# CreatedDate:  2022-12-22 13:55:01 +0900
# LastModified: 2022-12-29 18:37:27 +0900
#


ln -s ./.zshrc $HOME/.zshrc
ln -s ./.zshenv $HOME/.zshenv
ln -s ./.config/nvim $HOME/.config/nvim
ln -s ./.config/dein $HOME/.config/dein
ln -s ./.config/template $HOME/.config/template
ln -s ./.config/snippets $HOME/.config/snippets
ln -s ./.vimrc $HOME/.vimrc
ln -s ./.wezterm.lua $HOME/.wezterm.lua
return
