#!/bin/zsh
#
# FileName: 	create_symbolic.sh
# CreatedDate:  2022-12-22 13:55:01 +0900
# LastModified: 2023-01-26 17:32:08 +0900
#


if [[ -e $HOME/.zshrc ]]
then
  rm $HOME/.zshrc
fi
if [[ -e $HOME/.zshenv ]]
then
  rm $HOME/.zshenv
fi
if [[ ! -d $HOME/.config ]]
then
  mkdir $HOME/.config
fi

ln -sf $PWD/.zshrc $HOME/.zshrc
ln -sf $PWD/.zshenv $HOME/.zshenv
ln -sf $PWD/.config/nvim $HOME/.config/nvim
ln -sf $PWD/.config/dein $HOME/.config/dein
ln -sf $PWD/.config/template $HOME/.config/template
ln -sf $PWD/.config/snippets $HOME/.config/snippets
ln -sf $PWD/.vimrc $HOME/.vimrc
ln -sf $PWD/.wezterm.lua $HOME/.wezterm.lua
return
