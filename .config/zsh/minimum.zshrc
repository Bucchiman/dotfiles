#!/bin/zsh
#
# FileName:     minimum
# Author:       8ucchiman
# CreatedDate:  2024-01-20 16:54:28
# LastModified: 2024-03-10 14:58:30
# Reference:    8ucchiman.jp
# Description:  This is mininum zsh config.
#               How to use?
#               echo "source $HOME/.config/zsh/minimum.zshrc"
#


source $HOME/.config/zsh/core.zsh && base
source $HOME/.config/zsh/dev.zsh
source $HOME/.config/zsh/aliases.zsh && 8ucchiman_aliases && xero_aliases
source $HOME/.config/local/local.zsh
source $HOME/.config/zsh/etc.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
