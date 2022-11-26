_has() {
    return $( whence $1 &>/dev/null )
}

colorlist() {
    for color in {000..015}; do
        print -nP "%F{$color}$color %f"
    done
    printf "\n"
    for color in {016..255}; do
        print -nP "%F{$color}$color %f"
        if [ $(($((color-16))%6)) -eq 5 ]; then
            printf "\n"
        fi
    done
}


#---------------#
#  completion   #
#---------------#
autoload -Uz compinit     # Enable a function of complementation
compinit -u

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # Ignore whether the character is a capital letter or not.
eval `dircolors`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#---------------#
#    prompt     #
#---------------#
autoload -Uz add-zsh-hook vcs_info lprompt rprompt
autoload -U colors       # Set PROMPT colors
colors
setopt prompt_subst   # プロンプトの文字列を変えられる

add-zsh-hook precmd vcs_info
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



# create_item $1 [kind] 
#             $2 [foreground color(left triangle)] 
#             $3 [background color(left triangle+text)]
#             $4 [foreground color(text)]
#             $5 [background color(right triangle)]
#             $6 [text]
# LEFT_SEGMENT_SEPARATOR \ue0b0 
# RIGHT_SEGMENT_SEPARATOR \ue0b2
# PLUS_MINUS \u00b1
# GIT_BRANCH \ue0a0
# LIGHTNING  \u26a1
# SETTINGS   \u2699"

function create_item() {
    if [[ $1 == "litem" ]]
    then
        echo "%F{$2}%K{$3}\ue0b0%k%f%K{$3}%F{$4}$5%f%k"
    elif [[ $1 == "litem_right" ]]
    then
        echo "%F{$2}%K{$3}\ue0b0%k%f%K{$3}%F{$4}$5%f%k%F{$3}\ue0b0%f"
    elif [[ $1 == "ritem" ]]
    then
        echo "%F{$2}%K{$3}\ue0b2%k%f%K{$3}%F{$4}$5%f%k"
    fi
}

function lprompt() {
    case `uname` in 
        "Linux" )
            machine_icon=" \uF17C "
            ;;
        "Apple" )
            machine_icon=" \uF179 "
            ;;
        * )
            machine_icon=""
            ;;
    esac
    machine_prompt=`create_item litem 237 000 255 $machine_icon`
    name_prompt=`create_item litem 000 001 255 8ucchiman`
    pwd_prompt=`create_item litem_right 001 008 255 %~`
    echo $machine_prompt$name_prompt$pwd_prompt
}


function rprompt() {
    git_prompt=""

    git_check=`git status > /dev/null 2>&1; echo $?`
    if [[ $git_check != 0 ]]
    then
        echo $git_prompt
    fi

    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]
    then
        git_prompt=" %1(v|%K{green}%F{255}[%1v]%f%k|)"
        #git_prompt="%1"(v|`create_item ritem 001 008 255 %1v`"|)"
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]
    then
        git_prompt=" %1(v|%K{yellow}%F{255}[%1v]%f%k|)"
        #git_prompt="%1"(v|`create_item ritem 002 008 255 %1v`"|)"
    else [[ -n `echo "$st" | grep "^# Untracked"` ]];
        git_prompt=" %1(v|%K{red}%F{255}[%1v]%f%k|)"
    fi
    echo $git_prompt
}


# コマンドを打つたびに呼び出される
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "${vcs_info_msg_0_}" ]] && psvar[1]="${vcs_info_msg_0_}"
    PS1=`lprompt`" "
    RPS1=`rprompt`
}


#---------------#
#     alias     #
#---------------#
alias ls='ls --color'

#---------------#
#    setopt     #
#---------------#
setopt IGNORE_EOF   # Prevent pc from logout
setopt NO_CLOBBER   # リダイレクトでの上書き無効
# setopt CORRECT_ALL  # コマンドのタイプミス訂正 
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS # ヒストリ中に同じコマンドを含まないようにする
setopt HIST_IGNORE_ALL_DUPS # Don't produce duplications of the same in history
setopt HIST_REDUCE_BLANKS   # コマンド行の余分な余白を詰めてヒストリに加える
setopt HIST_NO_STORE    # ヒストリにhistoryコマンドを残さない
setopt HIST_IGNORE_SPACE    # コマンド先頭にスペースがある場合そのコマンドをヒストリに記録しない
setopt AUTO_CD  # cdコマンドを略す
setopt AUTO_MENU
setopt AUTO_NAME_DIRS   # 変数をディレクトリパスとして利用する 
setopt LIST_PACKED # 補完候補を詰めて表示
setopt LIST_ROWS_FIRST # 補完候補をそーとかして表示
setopt CDABLE_VARS
setopt AUTO_PUSHD   # cdコマンドで自動的にpushd
#setopt PUSHD_TO_HOME
setopt PUSHD_IGNORE_DUPS
setopt AUTO_RESUME  # サスペンド中のプロセスと同じコマンド名の頭文字を実行した場合、呼び出せる
setopt INTERACTIVE_COMMENTS # コマンドラインでも # 以降をコメントと見なす
setopt NUMERIC_GLOB_SORT #文字ではなく、数値としてsortする
setopt NULL_GLOB
#setopt RM_STAR_WAIT
setopt COMPLETE_IN_WORD # カーソル位置で補完する。
setopt ALWAYS_TO_END # Move cursor to the end of a completed word.
setopt ALWAYS_LAST_PROMPT # プロンプトを保持したままファイル名一覧を順次その場で表示(default=on)
setopt EXTENDED_GLOB    # ^(否定表現), ~(条件絞り)などの特殊文字を使用できるようにする

#---------------#
#    特殊変数   #
#---------------#
cdpath=(${HOME} /mnt/c/Users/bucchiman /mnt/d)  # auto_cd move directory with cdpath
fpath=(${HOME}/.zsh/func $HOME/.zsh/completion $fpath)
#manpath
#DIRSTACKSIZE=20
#fignore
LISTMAX=20      # 補完候補数
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # 単語の一部とみなされる記号文字列のリスト. 設定していない記号文字は区切り文字として認識する.omit the the '/' character.

# ヒストリーの保存場所を指定
SAVEHIST=100000           # Preserve the number of histories
HISTSIZE=100000
HISTFILE=$HOME/.zhistory     # Set the file which preserves histories


[ -n "`alias run-help`" ] && unalias run-help
autoload run-help

watch=(all)
LOGCHECK=20




# dotnet
switch.net7() {
    export DOTNET_ROOT=$HOME/.dotnet/dotnet_7.0
    export PATH=$PATH:$HOME/.dotnet/dotnet_7.0
}
switch.net6() {
    export DOTNET_ROOT=$HOME/.dotnet/dotnet_6.0
    export PATH=$PATH:$HOME/.dotnet/dotnet_6.0
}





#---------------#
#   fzf & ag    #
#---------------#
# fzf から the_silver_searcher (ag) を呼び出すことで高速化
if _has fzf && _has ag; then
    export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_COMMON_MYOPTS="--height 40% --layout=reverse --multi"
    export FZF_DEFAULT_OPTS="$FZF_COMMON_MYOPTS --preview 'bat --color=always {} --style=plain'"
    export FZF_CTRL_T_OPTS="$FZF_COMMON_MYOPTS --bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort' --border --preview 'bat --color=always {}'"
fi

alias f="fzf --preview 'batcat --color=always {}'"
alias F="fzf --height 100% --preview 'batcat --color=always {}'"

#---------------#
#   ls setting  #
#---------------#
export LS_COLORS='fi=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:'
LS_COLORS+='pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32'
LS_COLORS+=':no=38;5;248'

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
#LS_COLORS=$LS_COLORS:'di=5;97' ; export LS_COLORS
hash -d w=/mnt/c/Users/bucchiman

