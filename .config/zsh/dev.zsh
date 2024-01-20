#!/bin/zsh
#
# FileName:     dev
# Author:       8ucchiman
# CreatedDate:  2024-01-20 16:43:15
# LastModified: 2024-01-20 21:42:53
# Reference:    8ucchiman.jp
# Description:  ---
#


function _has() {
    return $( whence $1 &>/dev/null )
}


function show_oneline_snippets() {
    #
    # @Description  this is widget function.
    #               show oneline command
    # @params       
    # @Example
    # @Reference    
    #

    #local snippets=$(/bin/cat $HOME/.config/lib/onelines | fzf | cut -d':' -f2-)
    #local snippets=$(cd $HOME/.config/lib/onelines; /usr/bin/find . -type f | fzf --height 100%)
    local snippets=$(cd $HOME/.config/lib/onelines; /usr/bin/find . -type f | F )
    # echo $snippets
    local command=$(/bin/cat $HOME/.config/lib/onelines/$snippets | awk '/Command/{print}' | cut -d'>' -f2-)
    LBUFFER="${LBUFFER}${command}"
    #LBUFFER="${LBUFFER}${snippets//\\//}"
    zle reset-prompt
}
zle -N show_oneline_snippets
stty -ixon
bindkey '^s^o' show_oneline_snippets

####################################################################
# https://qiita.com/mollifier/items/b72a108daab16a18d34a
function zreload() {
    if [[ "${#}" -le 0 ]]; then
        echo "Usage: $0 FILE..."
        echo 'Reload specified files as an autoloading function'
        return 1
    fi

    local file function_path function_name
    for file in "$@"; do
        if [[ -z "$file" ]]; then
            continue
        fi

        function_path="${file:h}"
        function_name="${file:t}"

        if (( $+functions[$function_name] )) ; then
            # "function_name" is defined
            unfunction "$function_name"
            FPATH="$function_path" autoload -Uz +X "$function_name"
        fi
    done
}

# この行は .zshrc の他の箇所で書いている場合は改めて書かなくて良い
autoload -Uz add-zsh-hook

function _auto_reload_hook {
    # reload functions in current directory automatically
    [[ -n "$AUTO_RELOAD_TARGET_DIRECTORY" ]] \
    && [[ "$AUTO_RELOAD_TARGET_DIRECTORY" == "$PWD" ]] \
    && zreload $PWD/*(N.,@)
}
add-zsh-hook preexec _auto_reload_hook

function enable_auto_reload {
    AUTO_RELOAD_TARGET_DIRECTORY=$PWD
}

function disable_auto_reload {
    AUTO_RELOAD_TARGET_DIRECTORY=""
}
####################################################################

autoload -Uz Bmods Bmain
enable_auto_reload

function fuzzy_settings () {
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

}
if _has fzf; then
    fuzzy_settings
fi

if _has starship; then
    eval "$(starship init zsh)"
fi

if _has fnm ; then
    eval "$(fnm env --use-on-cd)"
fi

return
