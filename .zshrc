_has() {
    return $( whence $1 &>/dev/null )
}


# setting prompt
autoload -Uz vcs_info
autoload -U colors       # Set PROMPT colors
colors
setopt prompt_subst


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

# コマンドを打つたびに呼び出される
precmd () {
        # dir path
        path_prompt="[%{${fg[green]}%}%~%{${fg[default]}%}]" 
        # vcs_info
        psvar=()
        LANG=en_US.UTF-8 vcs_info
        [[ -n "${vcs_info_msg_0_}" ]] && psvar[1]="${vcs_info_msg_0_}"

        # check if version control by git is done
        git_check=1
        echo $PWD | awk -v pwd=$PWD '
            BEGIN{
                split(pwd, A, "/")
                A[length(A)+1]=" "
            }
            END{
                for (i=length(A); i>1; i--){
                    sub("/"A[i]"$", "", pwd)
                    printf " %s", pwd
                }
            }
        ' | read -A dir_list


        for dir in $dir_list
        do
            if [[ -n `\ls -a $dir | grep "^\.git$"` ]]
            then
                git_check=0
            fi
        done
        dir=""
        # check if branch is master or not
#        if [[ `echo ${vcs_info_msg_0_} | grep -c "master"` > 0 ]]; then
#            branch="m"
#        else
#            branch="s"
#        fi

        # make prompt each git status
        if [[ $git_check -eq 0 ]]; then
                st=`git status 2> /dev/null`
                if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
                        git_prompt=" [%1(v|%K{green}%1v%k|)]"
                elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
                        git_prompt=" [%1(v|%K{yellow}%1v%k|)]"
                else [[ -n `echo "$st" | grep "^# Untracked"` ]];
                        git_prompt=" [%1(v|%K{red}%1v%k|)]"
                fi
        else
                git_prompt=""
        fi
#        git_prompt=`printf '%s%s%s' "$(tput blink)" "${git_prompt}" "$(tput sgr0)"`


        # env version
        if [[ `\ls -1 | grep -c "\.py$"` > 0 ]]; then
            PYTHON_VERSION_STRING=" py:"$(python --version | sed "s/Python //")
            PYTHON_VIRTUAL_ENV_STRING=""
            if [ -n "$VIRTUAL_ENV" ]; then
                PYTHON_VIRTUAL_ENV_STRING="$(pyenv version-name)"
            fi
        fi
        # RUBY_VERSION_STRING=" rb:"$(ruby --version | sed "s/ruby \(.*\) (.*$/\1/")
        # if [[ `ls -1 | grep -c "\.tf$"` > 0 ]]; then
        #     TERRAFORM_VERSION_STRING=" tf:"$(terraform --version | grep "Terraform" | sed "s/Terraform v//")
        # fi

#        env_prompt=`printf '%s%s%s%s' "$(tput setab 004)" "$(tput blink)" "${PYTHON_VIRTUAL_ENV_STRING}" "$(tput sgr0)"`
#        env_prompt="%{${fg[yellow]}%}${PYTHON_VERSION_STRING}${PYTHON_VIRTUAL_ENV_STRING}%{${fg[default]}%}"
        env_prompt="%K{blue}%F{8}${PYTHON_VIRTUAL_ENV_STRING}%f%k"


#        if [[ -n `jobs | grep "suspended"` ]]; then
#            name_color=${fg[blue]}
#        else
#            name_color=${fg[cyan]}
#        fi
#        if type "kube_ps1" > /dev/null 2>&1; then
#            kube=" $(kube_ps1)"
#        else
#            kube=""
#        fi
        
        PS1="%{${fg[yellow]}%}Bucchiman%{${fg[default]}%}${path_prompt}${env_prompt}${git_prompt}%% "

        PYTHON_VERSION_STRING=""
        PYTHON_VIRTUAL_ENV_STRING=""
        # TERRAFORM_VERSION_STRING=""
}

fpath=(${HOME}/.zsh/func $fpath)
autoload -U compinit     # Enable a function of complementation
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'             # Ignore whether the character is a capital letter or not.
eval `dircolors`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# ヒストリーの保存場所を指定
SAVEHIST=100000           # Preserve the number of histories
HISTSIZE=100000
HISTFILE=~/.zhistory     # Set the file which preserves histories


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

# alias airport='/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I'
alias reedbush='ssh -l i95007 reedbush.cc.u-tokyo.ac.jp'
alias pcat='python -m pickle'
# alias jupyter='jupyter notebook'
alias bucket2='ssh bucket2'
alias ls='ls --color'

setopt IGNORE_EOF   # Prevent pc from logout
setopt NO_CLOBBER   # リダイレクトでの上書き無効
# setopt CORRECT_ALL
setopt EXTENDED_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS # ヒストリ中に同じコマンドを含まないようにする
setopt HIST_IGNORE_ALL_DUPS         # Don't produce duplications of the same in history
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
setopt AUTO_RESUME  # サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt INTERACTIVE_COMMENTS # コマンドラインでも # 以降をコメントと見なす
setopt NUMERIC_GLOB_SORT #文字ではなく、数値としてsortする
setopt NULL_GLOB
#setopt RM_STAR_WAIT

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey -e
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

[ -n "`alias run-help`" ] && unalias run-help
autoload run-help


watch=(all)
LOGCHECK=20

cdpath=(${HOME})
# you can move to home directory
# you can also set the array, which makes you some cdpath.
DIRSTACKSIZE=10
# you can set maximum of directories
#FIGNORE=(.o \~)
LISTMAX=10
# you can set maximum of lists
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'  # omit the the '/' character.



# to use terminalizer #
if [ -d ${HOME}/node_modules/.bin ]; then
    export PATH=${HOME}/node_modules/.bin:${PATH}
fi


eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# itemplot バックエンドに図を表示
export MPLBACKEND="module://itermplot"

# mypath=(~/mypath $mypath)
# autoload ${mypath[1]}/*(:t)


# mail config
#MAILPATH="/var/mail/$USER?${fg_bold[red]}NEW mail in \$_."
#MAILCHECK=3600

export PATH=${HOME}/jdk-11.0.7/bin:$PATH
# カーソル位置で補完する。
setopt complete_in_word
# Move cursor to the end of a completed word.
setopt always_to_end
# プロンプトを保持したままファイル名一覧を順次その場で表示(default=on)
setopt always_last_prompt
