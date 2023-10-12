function _has() {
    return $( whence $1 &>/dev/null )
}

if [[ -d $HOME/.config/local ]]
then
    export LOCALZSHRC="$HOME/.config/local"
    source $HOME/.config/local/local.zsh
fi

function colorlist() {
    for color in {000..015}; do
        print -nP "%F{$color}$color %f"
        print -nP "%K{$color}$color %k"
    done
    printf "\n"
    for color in {016..255}; do
        print -nP "%F{$color}$color %f"
        if [ $(($((color-16))%6)) -eq 5 ]; then
            printf "\n"
        fi
    done
}


function colorhex() {
    # https://askubuntu.com/questions/1405822/printf-statement-with-background-and-foreground-colours
    # printf '\033[41;32m%s\033[0m\n' foobar
    for color in {000..255}; do
        hex_color=`printf "%04x" $color`
        print -nP "%F{$color}$hex_color %f"
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
    search_name=("ubuntu"  "mac"  "raspbian"  )
    for os in ${(k)search_name}
    do
        neofetch distro | grep -Hi "$os" > /dev/null 2>&1
        if [ $? = 0 ]
        then
            echo "$search_name[$os] "
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
    #psvar=()
    #[[ -n "${vcs_info_msg_0_}" ]] && psvar[1]="${vcs_info_msg_0_}"
    #PS1=`lprompt`" "
    #RPS1=`rprompt`
}



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
#setopt CDABLE_VARS
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


#---------------#
#   ls setting  #
#---------------#
export LS_COLORS='fi=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:'
LS_COLORS+='pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32'
LS_COLORS+=':no=38;5;248'

zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
#LS_COLORS=$LS_COLORS:'di=5;97' ; export LS_COLORS
hash -d w=/mnt/c/Users/bucchiman

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

function open_nvim () {
    nvim .
}
zle -N open_nvim
bindkey '^_' open_nvim

function paste_module() {
    #local load_file=$(cat $HOME/.config/lib/onelines | fzf | cut -d':' -f2-)
    local load_file=$(cd $HOME/.config/lib/codes; /usr/bin/find . -type f | F )
    load_file="${HOME}/.config/lib/codes/${load_file}"
    sed -i 's/\r//' ${load_file}
    local module=`cat ${load_file}`
    LBUFFER="${LBUFFER}${module}"
    zle reset-prompt
}

zle -N paste_module
stty -ixon
bindkey '^s^p' paste_module

function make_file_from_library() {
    local load_file=$(cd $HOME/.config/lib/codes; /usr/bin/find . -type f | F )
    load_file="${HOME}/.config/lib/codes/${load_file}"
    sed -i 's/\r//' ${load_file} 2>/dev/null
    cp ${load_file} . 2>/dev/null
    zle reset-prompt
}
zle -N make_file_from_library
bindkey '^s^m' make_file_from_library

function show_online_snippets() {
    #local snippets=$(cat $HOME/.config/lib/onelines | fzf | cut -d':' -f2-)
    #local snippets=$(cd $HOME/.config/lib/onelines; /usr/bin/find . -type f | fzf --height 100%)
    local snippets=$(cd $HOME/.config/lib/onelines; /usr/bin/find . -type f | F )
    local command=$(cat $HOME/.config/lib/onelines/$snippets | awk '/Command/{print}' | cut -d'>' -f2-)
    LBUFFER="${LBUFFER}${command}"
    #LBUFFER="${LBUFFER}${snippets//\\//}"
    zle reset-prompt
}
zle -N show_online_snippets
bindkey '^s^o' show_online_snippets

function edit_library() {
    local edit_path=( \
        $HOME/.config/lib/codes/lua \
        $HOME/.config/lib/codes/rust \
        $HOME/.config/lib/codes/csharp \
        $HOME/.config/lib/codes/cuda \
        $HOME/.config/lib/codes/c \
        $HOME/.config/lib/codes/c++ \
        $HOME/.config/lib/codes/python \
        $HOME/.config/lib/codes/assembler \
        $HOME/.config/lib/codes/compiler \
        $HOME/.config/lib/codes/IoT \
        $HOME/.config/lib/codes/shell \
        $HOME/.config/lib/codes/Makefile \
        $HOME/.config/lib/onelines \
        $HOME/.config/lib/readme \
        $HOME/git/base_docker \
        $HOME/.config/lib/projects_temp \
        $HOME/.config/template \
        $HOME/.config/snippets \
        $HOME/.zshrc \
        $HOME/.config/zsh \
        $HOME/.config/local
        #$HOME/.config/lib/codes/CMakeList
    )
    local load_lib=$(printf "%s\n" $edit_path[@]| fzf --height 100%)
    #local load_file=$(cd $HOME/.config/snippets/codes; /usr/bin/find . -type f | f )
    #load_file="${HOME}/.config/snippets/codes/${load_file}"
    # https://ex1.m-yabe.com/archives/4548
    if [[ $load_lib == "$HOME/.config/snippets" || $load_lib == "$HOME/.config/template" ]]; then
        local load_file=$(/bin/ls $load_lib | fzf --height 100%)
        if [[ -n $load_file ]]; then
            nvim $load_lib/$load_file
        fi
        zle reset-prompt
    elif [[ -n $load_lib ]]; then
        cd $load_lib; nvim $load_lib
        zle reset-prompt
    else
    fi
}
zle -N edit_library
bindkey '^s^e' edit_library

function link_from_library() {
    local load_file=$(cd $HOME/.config/lib/codes; /usr/bin/find . -type f | fzf --height 100% )
    load_file=$load_file[3,-1]
    load_file="${HOME}/.config/lib/codes/${load_file}"
    if [[ ${load_file} = ${HOME}/.config/lib/codes/ ]]
    then
    else
        ln -s ${load_file} . 2>/dev/null
    fi
    zle reset-prompt
}
zle -N link_from_library
bindkey '^s^l' link_from_library

function make_projects() {
    local load_project=$(/bin/ls $HOME/.config/lib/projects_temp | fzf --height 100% )
    LBUFFER="${LBUFFER}rsync -auv $HOME/.config/lib/projects_temp/${load_project} ."
    zle reset-prompt
}
zle -N make_projects
bindkey '^m^p' make_projects

function lcds() {
    # 25:cpp
    local no_problem=`echo $1 | awk -F ":" '{print $1}'`
    local lang=`echo $1 | awk -F ":" '{print $2}'`
    lcd show ${no_problem} -g -l ${lang}
}

function docker_lazy () {
    lazydocker
    zle reset-prompt
}
zle -N docker_lazy
bindkey '^d^d' docker_lazy

function make_docker() {
    local load_docker=$(cd $HOME/git/base_docker; /usr/bin/find . -path "./.git" -prune -o -type f -name "*.Dockerfile" | fzf --height 100%)
    if [[ -n $load_docker ]]
    then
        cp -p ${HOME}/git/base_docker/${load_docker} ${PWD}/Dockerfile
        cp -p ${HOME}/git/base_docker/build_image.sh ${PWD}/build_image.sh
        cp -p ${HOME}/git/base_docker/make_container.sh ${PWD}/make_container.sh
    fi
    zle reset-prompt
}
zle -N make_docker
bindkey '^d^m' make_docker

function link_docker() {
    local load_docker=$(cd $HOME/git/base_docker; /usr/bin/find . -path "./.git" -prune -o -type f -name "*.Dockerfile" | fzf --height 100% )
    if [[ -n $load_docker ]]
    then
        ln -sf ${HOME}/git/base_docker/${load_docker} ${PWD}/Dockerfile
        cp -p ${HOME}/git/base_docker/build_image.sh ${PWD}/build_image.sh
        cp -p ${HOME}/git/base_docker/make_container.sh ${PWD}/make_container.sh
    fi
    zle reset-prompt
}
zle -N link_docker
bindkey '^d^l' link_docker

function git_lazy () {
    lazygit
    zle reset-prompt
}
zle -N git_lazy
bindkey '^g^g' git_lazy

function show_hotstation () {
    local load_project=$(cat $HOME/.config/local/hotstation | fzf --height 100% )
    if [[ -n $load_project ]]; then
        cd $load_project; nvim $load_project
    fi
    zle reset-prompt
}
zle -N show_hotstation
bindkey '^s^h' show_hotstation

function rm_hotstation () {
    local load_project=$(cat $HOME/.config/local/hotstation | fzf --height 100% )
    local target_load_project=$(echo $load_project | sed -e 's/\//\\\//g')
    if [[ -n $load_project ]]; then
        sed -i -e "/$target_load_project/d" $HOME/.config/local/hotstation
    fi
    zle reset-prompt
}
zle -N rm_hotstation
bindkey '^s^h^r' rm_hotstation

function add_hotstation () {
    target_project=$PWD
    local hotstation=($(cat $HOME/.config/local/hotstation))
    if (( ${hotstation[(I)$target_project]} )); then
        echo This project is contained in hotstation.
    else
        echo Add this project in hotstation...
        echo $target_project >> $HOME/.config/local/hotstation
    fi
    zle reset-prompt
}
zle -N add_hotstation
bindkey '^s^h^a' add_hotstation

# function git_diff () {
#     git diff
#     zle reset-prompt
# }
# zle -N git_diff
# bindkey '^g^d' git_diff
# 
# function git_add () {
#     git add .
#     zle reset-prompt
# }
# zle -N git_add
# bindkey '^g^a' git_add
# 
# function git_fetch () {
#     git fetch
#     zle reset-prompt
# }
# zle -N git_fetch
# bindkey '^g^f' git_fetch
# 
# function github_issue_list () {
#     gh issue list
#     zle reset-prompt
# }
# zle -N github_issue_list
# bindkey '^g^i^l' github_issue_list
# 
# function github_issue_create () {
#     gh issue create
#     zle reset-prompt
# }
# zle -N github_issue_create
# bindkey '^g^i^c' github_issue_create
# 
# function git_status () {
#     git status -sb
#     zle reset-prompt
# }
# zle -N git_status
# bindkey '^g^s' git_status
# 
# function git_reset () {
#     git reset
#     zle reset-prompt
# }
# zle -N git-reset
# bindkey '^g^r' git-reset
# 
# function github_pull_request_create () {
#     zle reset-prompt
# }
# zle -N github_pull_request_create
# bindkey '^g^p^c' github_pull_request_create

function show_readme() {
    local load_readme=$(cd $HOME/.config/lib/readme; /usr/bin/find . -type f | fzf --height 100% )
    mdcat $HOME/.config/lib/readme/$load_readme
    zle reset-prompt
}
zle -N show_readme
bindkey '^s^r' show_readme

# function move_dotfiles () {
#     (cd $HOME/git/dotfiles; nvim .)
# }
# zle -N move_dotfiles
# bindkey '^8' move_dotfiles


#[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh


function prepare_byobu () {
    byobu new -s interactive
}

function samples () {
    local sample_dir=$( cd $HOME/.config/sample; /usr/bin/find . -type d | fzf --height 100% )
    if [[ -n $sample_dir ]]; then
        local sample_file=$( /bin/ls $HOME/.config/sample/$sample_dir | fzf --height 100% )
        cp $HOME/.config/sample/$sample_dir/$sample_file .
    fi
    zle reset-prompt
}
zle -N samples
bindkey '^[S' samples
bindkey '^s^w' samples

# https://stackoverflow.com/questions/47004243/module-installed-by-luarocks-not-found
if type luarocks > /dev/null; then
    eval "$(luarocks path)"
fi

source $HOME/.config/zsh/aliases.zsh
xero_aliases
8ucchiman_aliases
return
