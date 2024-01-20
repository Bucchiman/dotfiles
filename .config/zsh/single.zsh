#!/bin/zsh



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
    local snippets=$(cd $HOME/.config/lib/onelines; /usr/bin/find . -type f | fzf --height 100% --preview 'cat {}' )
    # echo $snippets
    local command=$(/bin/cat $HOME/.config/lib/onelines/$snippets | awk '/Command/{print}' | cut -d'>' -f2-)
    LBUFFER="${LBUFFER}${command}"
    #LBUFFER="${LBUFFER}${snippets//\\//}"
    zle reset-prompt
}
#zle -N show_oneline_snippets
#bindkey '^s^o' show_oneline_snippets

autoload -Uz show_oneline_snippets
zle -N show_oneline_snippets
bindkey '^T' show_oneline_snippets
