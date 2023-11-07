#!/bin/zsh




cd $HOME/dotfiles


if [[ ! -d $HOME/.config ]]
then
  mkdir $HOME/.config
fi
#git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim


ln -sf $PWD/.zshrc $HOME/.zshrc
ln -sf $PWD/.zshenv $HOME/.zshenv
ln -sf $PWD/Bmods $HOME
ln -sf $PWD/Bmain $HOME
ln -sf $PWD/.config/nvim $HOME/.config/nvim
#ln -sf $PWD/.config/dein $HOME/.config/dein
#ln -sf $PWD/.config/lib/codes/lua/nvim/lua/plugins/config/template $PWD/.config
#ln -sf $PWD/.config/lib/codes/lua/nvim/lua/plugins/config/snippets $PWD/.config
ln -sf $PWD/.config/template $HOME/.config/
ln -sf $PWD/.config/snippets $HOME/.config/
ln -sf $PWD/.config/pockets $HOME/.config/
ln -sf $PWD/.vimrc $HOME
ln -sf $PWD/.wezterm.lua $HOME
ln -sf $PWD/.config/lib $HOME/.config/
ln -sf $PWD/.config/zsh $HOME/.config/
return
