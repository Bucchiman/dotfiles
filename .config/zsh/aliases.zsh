#!/bin/zsh
#
# FileName:     aliases
# Author:       8ucchiman
# CreatedDate:  2023-09-08 00:40:43
# LastModified: 2023-12-15 12:08:30
# Reference:    https://github.com/xero/dotfiles/blob/main/zsh/.config/zsh/06-aliases.zsh
# Description:  ---
#


#set -ex        # 途中のエラーで実行中断


function qiita_aliases () {
    #
    # @Description  
    # @params       
    # @Example      qiita_aliases
    # @Reference    https://qiita.com/reireias/items/d906ab086c3bc4c22147
    #

    
}


function xero_aliases () {
    #
    # https://github.com/xero/dotfiles/blob/main/zsh/.config/zsh/06-aliases.zsh
    #
    alias g="git"
    #alias e="$EDITOR"
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

function 8ucchiman_aliases () {
    alias ,,="source $HOME/.zshrc"
    alias a="alias"
    alias l="l"
    alias gba="git branch -a"
    alias gbd="git branch -d"
    # alias gbD="git branch -D"
    alias gfom="git fetch origin main"
    alias gfod="git fetch origin dev"
    alias gcod="git checkout dev"
    alias gcom="git checkout main"
    alias gmd="git merge dev"
    alias gmom="git merge --no-edit origin/main"
    alias gmod="git merge --no-edit origin/dev"
    alias gpom="git push -u origin main"
    alias gpod="git push origin dev"
    alias ghil="gh issue list"
    alias ghicr="gh issue create"
    alias ghiv="gh issue view"
    alias ghie="gh issue edit"
    # alias ghrc="gh repo create [repo name] --private"
    alias ghicl="gh issue close"
    alias ghis="gh issue status"
    alias h="hostname"
    alias 8n="nvim ."
    alias n="nvim"
    alias 8d="(cd $HOME/git/dotfiles; nvim .)"
    alias 8dl="(cd $HOME/git/dotfiles/.config/lib; nvim .)"

    #alias ls='exa --icons 2>/dev/null'
    function ls () { if exa --icons $1 2>/dev/null; then else ls --color=auto $1; fi }
    function cat () { if bat --color=always $1 2>/dev/null; then else cat $1; fi }
    #alias cat='bat --color=always {} 2>/dev/null || cat {}'

    alias f="fzf --preview 'cat {}'"
    alias F="fzf --height 100% --preview 'cat {}'"
    alias diff='diff --color'
    alias drive='skicka'
    alias 8gt='git clone git@github.com:Bucchiman/test.git'
    alias 8g='git clone git@github.com:Bucchiman'
    alias 8gd='git clone --recursive git@github.com:Bucchiman/dotfiles'
    #alias go8u='rsync -auvz --exclude {'.git','.gitignore'} /mnt/c/Users/yk.iwabuchi/git/dotfiles voyager:git/; rsync -auvz --exclude {'.git','.gitignore'} /mnt/c/Users/yk.iwabuchi/git/dotfiles voyager:git/;'
    #alias bat='bat'
}



return

