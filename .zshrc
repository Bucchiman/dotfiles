function _has() {
    return $( whence $1 &>/dev/null )
}


if [[ -d $HOME/.config/zsh ]]
then
    export LOCALZSHRC="$HOME/.config/zsh"
    source $HOME/.config/zsh/local.zshrc
fi

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

source $HOME/.zsh/git_completion/git-prompt.sh 2>/dev/null
autoload -Uz compinit && compinit

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#---------------#
#    prompt     #
#---------------#
autoload -Uz add-zsh-hook lprompt rprompt
autoload -U colors       # Set PROMPT colors
colors
setopt prompt_subst   # プロンプトの文字列を変えられる

#add-zsh-hook precmd vcs_info
## :vcs_info:git:*とするとgitの時のみの設定
## ローカルで変更を加えた時に通知するかを設定
#zstyle ':vcs_info:git:*' check-for-changes true
## addされた場合(インデックスに追加)+表示
#zstyle ':vcs_info:git:*' stagedstr "  "
## addされていない場合-表示
#zstyle ':vcs_info:git:*' unstagedstr "  "
## フォーマット表示 %b: branch名 %c: stagestr %u: unstagestr
#zstyle ':vcs_info:git:*' formats "%b%c%u"
## 異常状態(conflict, rebase状態)
#zstyle ':vcs_info:git:*' actionformats '%b|%a'


#LANG=en_US.UTF-8 vcs_info
# create_item $1 [kind] 
#             $2 [foreground color(left triangle)] 
#             $3 [background color(left triangle+text)]
#             $4 [foreground color(text)]
#             $5 [background color(right triangle)]
#             $6 [text]
#
# echo 
# echo 
# echo  (e0b0)
# echo 
# echo 


function create_item() {
    if [[ $1 == "litem" ]]
    then
        echo "%F{$2}%K{$3} %k%f%K{$3}%F{$4}$5%f%k"
    elif [[ $1 == "litem_left" ]]
    then
        echo "%F{$2}%K{$3} %k%f%K{$3}%F{$4}$5%f%k"

    elif [[ $1 == "litem_right" ]]
    then
        echo "%F{$2}%K{$3} %k%f%K{$3}%F{$4}$5%f%k%F{$3}%f"
    elif [[ $1 == "ritem" ]]
    then
        echo "%F{$2}%K{$3}%f%k%K{$2}%F{$4}$5%1v%f%k%F{$2}%K{$3}%f%k"
    fi
}

function get_machine_icon() {
    typeset -A search_name
    search_name=("ubuntu"  "apple" )
    for os in ${(k)search_name}
    do
        grep -Hi "$os" /etc/*release > /dev/null 2>&1
        if [ $? = 0 ]
        then
            echo "$search_name[$os]"
        fi
    done
}
autoload -Uz add-zsh-hook initialize_prompt get_machine_icon
function initialize_prompt() {
    MACHINE_ICON=`get_machine_icon`
    machine_prompt=`create_item litem_left 016 008 255 $MACHINE_ICON`
    name_prompt=`create_item litem 008 003 255 8ucchiman`
}
initialize_prompt


function lprompt() {
    #HOSTNAME=`hostname`
    #if [[ $HOSTNAME != $BASE_HOSTNAME ]]
    #then

    #fi

    path_prompt=`echo "$PWD" | awk -v home_dir=$HOME '{sub(home_dir, " ", $0); print $0}'`
    pwd_prompt=`create_item litem_right 003 012 255 $path_prompt"  "`

    #pwd_prompt=`create_item litem_right 003 012 255 " "%~`
    echo $machine_prompt$name_prompt$pwd_prompt
}


function rprompt() {
    git_prompt=""

    current=$PWD
    git_check=1

    while [[ $PWD != '/' ]]
    do
        if [[ -n `ls -a | grep "\.git$"` ]]; then
            git_check=0
            break
        else
            cd ../
        fi
    done
    cd $current

    if [[ `echo $vcs_info_msg_0_ | grep -c -e "master" -e "main"` > 0 ]]; then
        branch=" "
    else
        branch=" "
    fi

    if [[ $git_check -eq 0 ]]
    then
        st=`git status 2> /dev/null`
        if [[ -n `echo "$st" | grep "^nothing to"` ]]
        then
            git_prompt="`create_item ritem 014 016 255 $branch" "`"
            git_prompt=" %1(v|$git_prompt|)"
        elif [[ -n `echo "$st" | grep "^nothing added"` ]]
        then
            git_prompt="`create_item ritem 003 016 255 $branch" "`"
            git_prompt=" %1(v|$git_prompt|)"
        else [[ -n `echo "$st" | grep "^# Untracked"` ]];
            git_prompt="`create_item ritem 001 016 255 $branch" "`"
            git_prompt=" %1(v|$git_prompt|)"
        fi
    else
        git_prompt=""
    fi
    #git_prompt='%F{red}$(__git_ps1 "%s")%f'
    echo $git_prompt
}


# コマンドを打つたびに呼び出される
precmd () {
    psvar=()
    #[[ -n "${vcs_info_msg_0_}" ]] && psvar[1]="${vcs_info_msg_0_}"
    PS1=`lprompt`" "
    #RPS1=`rprompt`
}


#---------------#
#     alias     #
#---------------#
alias ls='exa --icons 2>/dev/null'
alias diff='diff --color'
alias drive='skicka'
#alias go8u='rsync -auvz --exclude {'.git','.gitignore'} /mnt/c/Users/yk.iwabuchi/git/dotfiles voyager:git/; rsync -auvz --exclude {'.git','.gitignore'} /mnt/c/Users/yk.iwabuchi/git/dotfiles voyager:git/;'
#alias bat='bat'

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



#---------------#
#   fzf & ag    #
#---------------#
# fzf から the_silver_searcher (ag) を呼び出すことで高速化
# fzf の キーバインド
#if [ -e /opt/local/share/fzf/shell/key-bindings.zsh ]; then
#    source /opt/local/share/fzf/shell/key-bindings.zsh
#fi

if [ -e $HOME/.fzf/shell/completion.zsh ]; then
    source $HOME/.fzf/shell/completion.zsh
fi

# fzf の 補完設定
#if [ -e /opt/local/share/fzf/shell/completion.zsh ]; then
#    source /opt/local/share/fzf/shell/completion.zsh
#fi

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

#---------------#
#   ls setting  #
#---------------#
export LS_COLORS='fi=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:'
LS_COLORS+='pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32'
LS_COLORS+=':no=38;5;248'

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
#LS_COLORS=$LS_COLORS:'di=5;97' ; export LS_COLORS
hash -d w=/mnt/c/Users/bucchiman



if [ -z "$SSH_AUTH_SOCK" ] ; then
    eval `ssh-agent -s` >/dev/null
    expect -c "
        set timeout 1
        spawn ssh-add
        expect \"password:\"
        send \"Cinemashkachikachika.17\n\"
        interact" >/dev/null
fi


export VISUAL=nvim
export EDITOR="$VISUAL"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

#---------------#
#DISPLAY setting#
#---------------#
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
#export DISPLAY=$(ip route list default | awk '{print $3}'):0
#export DISPLAY=`hostname`.mshome.net:0.0
export LIBGL_ALWAYS_INDIRECT=1

#source .custom.zsh
go_flag=0
function switch_go() {
    if [[ $go_flag == 0 ]]
    then
        unalias go
        go_flag=1
    else
        alias go="/bin/rm -f ./go~; ./go"
        go_flag=0
    fi
}

#if (which zprof > /dev/null 2>&1) ;then
#  zprof
#fi

function prev() {
    PREV=$(echo `history | tail -n2 | head -n1` | sed 's/[0-9]* //')
    sh -c "pet new `printf %q $PREV`"
}

function pet-select() {
    BUFFER=$(pet search --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle redisplay
}
#zle -N pet-select
#stty -ixon
#bindkey '^s' pet-select

function paste_snippets() {
    #local snippets=$(cat $HOME/.config/snippets/oneline | fzf | cut -d':' -f2-)
    #local load_file=$(/usr/bin/find $HOME/.config/snippets/codes -type f | peco)
    local load_file=$(cd $HOME/.config/snippets/codes; /usr/bin/find . -type f | f)
    load_file="${HOME}/.config/snippets/codes/${load_file}"
    sed -i 's/\r//' ${load_file}
    local snippets=`cat $HOME/.config/snippets/codes/${load_file}`
    LBUFFER="${LBUFFER}${snippets}"
    zle reset-prompt
}

zle -N paste_snippets
stty -ixon
bindkey '^s^p' paste_snippets

function make_file_from_snippets() {
    local load_file=$(cd $HOME/.config/snippets/codes; /usr/bin/find . -type f | f )
    load_file="${HOME}/.config/snippets/codes/${load_file}"
    sed -i 's/\r//' ${load_file} 2>/dev/null
    cp ${load_file} . 2>/dev/null
    zle reset-prompt
}
zle -N make_file_from_snippets
bindkey '^s^m' make_file_from_snippets

function show_online_snippets() {
    #local snippets=$(cat $HOME/.config/snippets/oneline | fzf | cut -d':' -f2-)
    local snippets=$(cd $HOME/.config/snippets/onelines; /usr/bin/find . -type f | fzf | cut -d':' -f2-)
    LBUFFER="${LBUFFER}${snippets//\\//}"
    zle reset-prompt
}
zle -N show_online_snippets
bindkey '^s^o' show_online_snippets

function edit_snippets() {
    #local load_file=$(cd $HOME/.config/snippets/codes; /usr/bin/find . -type f | f )
    #load_file="${HOME}/.config/snippets/codes/${load_file}"
    nvim $HOME/.config/snippets
}
zle -N edit_snippets
bindkey '^s^e' edit_snippets

fnction link_from_snippets() {
    local load_file=$(cd $HOME/.config/snippets/codes; /usr/bin/find . -type f | f )
    load_file="${HOME}/.config/snippets/codes/${load_file}"
    sed -i 's/\r//' ${load_file} 2>/dev/null
    ln -s ${load_file} . 2>/dev/null
    zle reset-prompt
}
zle -N link_from_snippets
bindkey '^s^l' link_from_snippets


[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

return

