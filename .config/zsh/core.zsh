#!/usr/bin/zsh
#
# FileName:     core
# Author:       8ucchiman
# CreatedDate:  2024-01-20 16:28:05
# LastModified: 2024-01-20 20:36:01
# Reference:    8ucchiman.jp
# Description:  ---
#


function base () {
    #---------------#
    #  completion   #
    #---------------#
    autoload -Uz compinit     # Enable a function of complementation
    compinit -u
    
    zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # Ignore whether the character is a capital letter or not.
    #eval `dircolors`
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
    
    autoload -Uz compinit && compinit
    
    autoload history-search-end
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
    bindkey -e
    bindkey "^P" history-beginning-search-backward-end
    bindkey "^N" history-beginning-search-forward-end
    typeset -U path PATH
    
    #---------------#
    #    prompt     #
    #---------------#
    autoload -Uz add-zsh-hook lprompt rprompt
    autoload -U colors       # Set PROMPT colors
    colors
    setopt prompt_subst   # プロンプトの文字列を変えられる

    #---------------#
    #   ls setting  #
    #---------------#
    export LS_COLORS='fi=00:mi=00:mh=00:ln=01;36:or=01;31:di=01;34:ow=04;01;34:st=34:tw=04;34:'
    LS_COLORS+='pi=01;33:so=01;33:do=01;33:bd=01;33:cd=01;33:su=01;35:sg=01;35:ca=01;35:ex=01;32'
    LS_COLORS+=':no=38;5;248'

    zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"


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
    fpath=($HOME/.config/zsh/functions ${HOME}/.zsh/func $HOME/.zsh/completion $fpath)

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


    export VISUAL=nvim
    export EDITOR="$VISUAL"

    #---------------#
    #DISPLAY setting#
    #---------------#
    #export DISPLAY=$(/bin/cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
    #export DISPLAY=$(ip route list default | awk '{print $3}'):0
    #export DISPLAY=`hostname`.mshome.net:0.0
    export LIBGL_ALWAYS_INDIRECT=1

}



return
