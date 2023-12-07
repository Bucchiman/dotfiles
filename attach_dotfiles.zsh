#!/bin/zsh

cd $HOME/dotfiles


mkdir -p $HOME/.config

#git clone --depth 1 https://github.com/wbthomason/packer.nvim $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim

if [[ ! -L $HOME/.zshrc ]]; then
    ln -sf $PWD/.zshrc $HOME
fi
if [[ ! -L $HOME/.zshenv ]]; then
    ln -sf $PWD/.zshenv $HOME
fi

if [[ ! -L $HOME/Bmods ]]; then
    ln -sf $PWD/Bmods $HOME
fi

if [[ ! -L $HOME/Bmain ]]; then
    ln -sf $PWD/Bmain $HOME
fi

if [[ ! -L $HOME/.config/nvim ]]; then
    ln -sf $PWD/.config/nvim $HOME/.config
fi

if [[ ! -L $HOME/.config/template ]]; then
    ln -sf $PWD/.config/template $HOME/.config/
fi

if [[ ! -L $HOME/.config/snippets ]]; then
    ln -sf $PWD/.config/snippets $HOME/.config/
fi

if [[ ! -L $HOME/.config/pockets ]]; then
    ln -sf $PWD/.config/pockets $HOME/.config/
fi

if [[ ! -L $HOME/.vimrc ]]; then
    ln -sf $PWD/.vimrc $HOME
fi

if [[ ! -L $HOME/.wezterm.lua ]]; then
    ln -sf $PWD/.wezterm.lua $HOME
fi

if [[ ! -L $HOME/.config/lib ]]; then
    ln -sf $PWD/.config/lib $HOME/.config
fi

if [[ ! -L $HOME/.config/zsh ]]; then
    ln -sf $PWD/.config/zsh $HOME/.config/
fi

if [[ ! -L $HOME/.config/systemd ]]; then
    ln -sf $PWD/.config/systemd $HOME/.config/
fi

if [[ ! -L $HOME/.config/cron ]]; then
    ln -sf $PWD/.config/cron $HOME/.config
fi
return
