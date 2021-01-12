_has() {
    return $( whence $1 &>/dev/null )
}


# setting prompt
autoload -Uz vcs_info
autoload -U colors       # Set PROMPT colors
colors
setopt prompt_subst
PS1="%{${fg[yellow]}%}bucchiman%{${fg[default]}%}[%{${fg[green]}%}%~%{${fg[default]}%}]%# "        #%{${fg[white]}%}"
#RPS1=' (%w %t) '


# :vcs_info:git:*とするとgitの時のみの設定
# ローカルで変更を加えた時に通知するかを設定
zstyle ':vcs_info:git:*' check-for-changes true
# addされた場合(インデックスに追加)+表示
zstyle ':vcs_info:git:*' stagedstr ":+"
# addされていない場合-表示
zstyle ':vcs_info:git:*' unstagedstr ":-"
# フォーマット表示 %b: branch名 %c: stagestr %u: unstagestr
zstyle ':vcs_info:git:*' formats "%b%c%u"
# 異常状態(conflict, rebase状態)
zstyle ':vcs_info:git:*' actionformats '%b|%a'

 

# fzf の キーバインド
if [ -e /opt/local/share/fzf/shell/key-bindings.zsh ]; then
    source /opt/local/share/fzf/shell/key-bindings.zsh
fi

# fzf の 補完設定
if [ -e /opt/local/share/fzf/shell/completion.zsh ]; then
    source /opt/local/share/fzf/shell/completion.zsh
fi

# fzf から the_silver_searcher (ag) を呼び出すことで高速化
if _has fzf && _has ag; then
    export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_COMMON_MYOPTS="--height 40% --layout=reverse --multi"
    export FZF_DEFAULT_OPTS="$FZF_COMMON_MYOPTS --preview 'bat --color=always {} --style=plain'"
    export FZF_CTRL_T_OPTS="$FZF_COMMON_MYOPTS --bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort' --border --preview 'bat --color=always {}'"
fi

alias f="fzf --preview 'bat --color=always {}'"
alias F="fzf --height 100% --preview 'bat --color=always {}'"

# ヒストリーの保存場所を指定
SAVEHIST=100000           # Preserve the number of histories
HISTSIZE=100000
HISTFILE=~/.zhistory     # Set the file which preserves histories
alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I'
alias reedbush='ssh -l i95007 reedbush.cc.u-tokyo.ac.jp'
alias pcat='python -m pickle'
# alias jupyter='jupyter notebook'
alias bucket2='ssh bucket2'
alias ls='ls --color'

autoload -U compinit     # Enable a function of complementation
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'             # Ignore whether the character is a capital letter or not.
eval `dircolors`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

setopt IGNORE_EOF        # Prevent pc from logouting
setopt NO_CLOBBER
#setopt CORRECT_ALL
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS                                                            # Don't produce duplications of the same in history
setopt HIST_REDUCE_BLANKS
setopt HIST_NO_STORE
setopt HIST_IGNORE_SPACE
setopt AUTO_CD
setopt AUTO_NAME_DIRS
setopt LIST_PACKED
setopt LIST_ROWS_FIRST
#setopt MENU_COMPLETE
setopt CDABLE_VARS
setopt AUTO_PUSHD
setopt PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS
setopt AUTO_RESUME
setopt INTERACTIVE_COMMENTS
setopt NULL_GLOB
setopt RM_STAR_WAIT

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

[ -n "`alias run-help`" ] && unalias run-help
autoload run-help


watch=(all)
LOGCHECK=20

cdpath=(~)
# you can move to home directory
# you can also set the array, which makes you some cdpath.
DIRSTACKSIZE=10
# you can set maximum of directories
#FIGNORE=(.o \~)
LISTMAX=10
#alias open=`open -a /Applications/Safari.app `
# you can set maximum of lists
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
# omit the the '/' character.


# alias safari="open -a /Applications/Safari.app https://www.youtube.com/watch?v=sJJk3maVzvA"

# to use terminalizer #
if [ -d ${HOME}/node_modules/.bin ]; then
    export PATH=${PATH}:${HOME}/node_modules/.bin
fi


eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# itemplot
export MPLBACKEND="module://itermplot"



# My functions #
fpath=(~/func $fpath)
autoload ${fpath[1]}/*(:t)

# mypath=(~/mypath $mypath)
# autoload ${mypath[1]}/*(:t)


# mail config
#MAILPATH="/var/mail/$USER?${fg_bold[red]}NEW mail in \$_."
#MAILCHECK=3600

export PATH=${HOME}/jdk-11.0.7/bin:$PATH

bindkey -e
