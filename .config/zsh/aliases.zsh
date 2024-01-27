#!/bin/zsh
#
# FileName:     aliases
# Author:       8ucchiman
# CreatedDate:  2023-09-08 00:40:43
# LastModified: 2024-01-20 18:51:36
# Reference:    https://github.com/xero/dotfiles/blob/main/zsh/.config/zsh/06-aliases.zsh
# Description:  ---
#


#set -ex        # 途中のエラーで実行中断

function _has() {
    return $( whence $1 &>/dev/null )
}

function qiita_aliases () {
    #
    # @Description  
    # @params       
    # @Example      qiita_aliases
    # @Reference    https://qiita.com/reireias/items/d906ab086c3bc4c22147
    #

    alias ls='ls -alF --color=auto'
    alias l='clear && ls'
    alias agi='sudo apt install'
    alias agy='sudo apt install -y'
    alias agr='sudo apt remove'
    alias agu='sudo apt update'


}


########################################
# while getopts :i:c:g OPT
# do
#     case $OPT in
#         i) image_name=$OPTARG;;
#         g) gpu_flag=true;;
#         c) container_name=$OPTARG;;
#         :|\?) _usage;;
#     esac
# done
# function _usage () {
#     echo 
# }
# function help () {
# 
# }
# 
# 
# function main02 () {
#     
# }
########################################

typeset -A SUBMODULES
function set_variables () {
    #
    #
    #
    #
    echo "******************************"
    echo "* set_variables              *"
    echo "******************************"
    BASE_DIR=$PWD
    SUBMODULES=(yolostereo3D https://github.com/Owen-Liuyuxuan/visualDet3D.git)
}


function setup_environment () {
}

function zsh_docker_aliases () {
    #
    # @Description  docker aliases
    # @params       
    # @Example
    # @Reference    https://github.com/akarzim/zsh-docker-aliases/blob/master/alias.zsh
    #

    alias dk='docker'
    alias dka='docker attach'
    alias dkb='docker build'
    alias dkd='docker diff'
    alias dkdf='docker system df'
    alias dke='docker exec'
    alias dkE='docker exec -e COLUMNS=`tput cols` -e LINES=`tput lines` -i -t'
    alias dkh='docker history'
    alias dki='docker images'
    alias dkin='docker inspect'
    alias dkim='docker import'
    alias dkk='docker kill'
    alias dkkh='docker kill -s HUP'
    alias dkl='docker logs'
    alias dkL='docker logs -f'
    alias dkli='docker login'
    alias dklo='docker logout'
    alias dkls='docker ps'
    alias dkp='docker pause'
    alias dkP='docker unpause'
    alias dkpl='docker pull'
    alias dkph='docker push'
    alias dkps='docker ps'
    alias dkpsa='docker ps -a'
    alias dkr='docker run'
    alias dkR='docker run -e COLUMNS=`tput cols` -e LINES=`tput lines` -i -t --rm'
    alias dkRe='docker run -e COLUMNS=`tput cols` -e LINES=`tput lines` -i -t --rm --entrypoint /bin/bash'
    alias dkRM='docker system prune'
    alias dkrm='docker rm'
    alias dkrmi='docker rmi'
    alias dkrn='docker rename'
    alias dks='docker start'
    alias dkS='docker restart'
    alias dkss='docker stats'
    alias dksv='docker save'
    alias dkt='docker tag'
    alias dktop='docker top'
    alias dkup='docker update'
    alias dkV='docker volume'
    alias dkv='docker version'
    alias dkw='docker wait'
    alias dkx='docker stop'


    alias dkC='docker container'
    alias dkCa='docker container attach'
    alias dkCcp='docker container cp'
    alias dkCd='docker container diff'
    alias dkCe='docker container exec'
    alias dkCE='docker container exec -e COLUMNS=`tput cols` -e LINES=`tput lines` -i -t'
    alias dkCin='docker container inspect'
    alias dkCk='docker container kill'
    alias dkCl='docker container logs'
    alias dkCL='docker container logs -f'
    alias dkCls='docker container ls'
    alias dkCp='docker container pause'
    alias dkCpr='docker container prune'
    alias dkCrn='docker container rename'
    alias dkCS='docker container restart'
    alias dkCrm='docker container rm'
    alias dkCr='docker container run'
    alias dkCR='docker container run -e COLUMNS=`tput cols` -e LINES=`tput lines` -i -t --rm'
    alias dkCRe='docker container run -e COLUMNS=`tput cols` -e LINES=`tput lines` -i -t --rm --entrypoint /bin/bash'
    alias dkCs='docker container start'
    alias dkCss='docker container stats'
    alias dkCx='docker container stop'
    alias dkCtop='docker container top'
    alias dkCP='docker container unpause'
    alias dkCup='docker container update'
    alias dkCw='docker container wait'

    alias dkI='docker image'
    alias dkIb='docker image build'
    alias dkIh='docker image history'
    alias dkIim='docker image import'
    alias dkIin='docker image inspect'
    alias dkIls='docker image ls'
    alias dkIpr='docker image prune'
    alias dkIpl='docker image pull'
    alias dkIph='docker image push'
    alias dkIrm='docker image rm'
    alias dkIsv='docker image save'
    alias dkIt='docker image tag'


    ## Volume (V)
    alias dkV='docker volume'
    alias dkVin='docker volume inspect'
    alias dkVls='docker volume ls'
    alias dkVpr='docker volume prune'
    alias dkVrm='docker volume rm'

    ## Network (N)
    alias dkN='docker network'
    alias dkNs='docker network connect'
    alias dkNx='docker network disconnect'
    alias dkNin='docker network inspect'
    alias dkNls='docker network ls'
    alias dkNpr='docker network prune'
    alias dkNrm='docker network rm'

    ## System (Y)
    alias dkY='docker system'
    alias dkYdf='docker system df'
    alias dkYpr='docker system prune'

    ## Stack (K)
    alias dkK='docker stack'
    alias dkKls='docker stack ls'
    alias dkKps='docker stack ps'
    alias dkKrm='docker stack rm'

    ## Swarm (W)
    alias dkW='docker swarm'

    ## CleanUp (rm)
    # Clean up exited containers (docker < 1.13)
    alias dkrmC='docker rm $(docker ps -qaf status=exited)'

    # Clean up dangling images (docker < 1.13)
    alias dkrmI='docker rmi $(docker images -qf dangling=true)'

    # Pull all tagged images
    alias dkplI='docker images --format "{{ .Repository }}" | grep -v "^<none>$" | xargs -L1 docker pull'

    # Clean up dangling volumes (docker < 1.13)
    alias dkrmV='docker volume rm $(docker volume ls -qf dangling=true)'

    # Docker Machine (m)
    alias dkm='docker-machine'
    alias dkma='docker-machine active'
    alias dkmcp='docker-machine scp'
    alias dkmin='docker-machine inspect'
    alias dkmip='docker-machine ip'
    alias dkmk='docker-machine kill'
    alias dkmls='docker-machine ls'
    alias dkmpr='docker-machine provision'
    alias dkmps='docker-machine ps'
    alias dkmrg='docker-machine regenerate-certs'
    alias dkmrm='docker-machine rm'
    alias dkms='docker-machine start'
    alias dkmsh='docker-machine ssh'
    alias dkmst='docker-machine status'
    alias dkmS='docker-machine restart'
    alias dkmu='docker-machine url'
    alias dkmup='docker-machine upgrade'
    alias dkmv='docker-machine version'
    alias dkmx='docker-machine stop'

    # Docker Compose (c)
    if [[ $(uname -s) == "Linux" ]]; then
        alias dkc='docker-compose'
        alias dkcb='docker-compose build'
        alias dkcB='docker-compose build --no-cache'
        alias dkccf='docker-compose config'
        alias dkccr='docker-compose create'
        alias dkcd='docker-compose down'
        alias dkce='docker-compose exec -e COLUMNS=`tput cols` -e LINES=`tput lines`'
        alias dkcev='docker-compose events'
        alias dkci='docker-compose images'
        alias dkck='docker-compose kill'
        alias dkcl='docker-compose logs'
        alias dkcL='docker-compose logs -f'
        alias dkcls='docker-compose ps'
        alias dkcp='docker-compose pause'
        alias dkcP='docker-compose unpause'
        alias dkcpl='docker-compose pull'
        alias dkcph='docker-compose push'
        alias dkcpo='docker-compose port'
        alias dkcps='docker-compose ps'
        alias dkcr='docker-compose run -e COLUMNS=`tput cols` -e LINES=`tput lines`'
        alias dkcR='docker-compose run -e COLUMNS=`tput cols` -e LINES=`tput lines` --rm'
        alias dkcrm='docker-compose rm'
        alias dkcs='docker-compose start'
        alias dkcsc='docker-compose scale'
        alias dkcS='docker-compose restart'
        alias dkct='docker-compose top'
        alias dkcu='docker-compose up'
        alias dkcU='docker-compose up -d'
        alias dkcv='docker-compose version'
        alias dkcx='docker-compose stop'
    else
        alias dkc='docker compose'
        alias dkcb='docker compose build'
        alias dkcB='docker compose build --no-cache'
        alias dkccp='docker compose copy'
        alias dkccr='docker compose create'
        alias dkccv='docker compose convert'
        alias dkcd='docker compose down'
        alias dkce='docker compose exec -e COLUMNS=`tput cols` -e LINES=`tput lines`'
        alias dkcev='docker compose events'
        alias dkci='docker compose images'
        alias dkck='docker compose kill'
        alias dkcl='docker compose logs'
        alias dkcL='docker compose logs -f'
        alias dkcls='docker compose ls'
        alias dkcp='docker compose pause'
        alias dkcP='docker compose unpause'
        alias dkcpl='docker compose pull'
        alias dkcph='docker compose push'
        alias dkcpo='docker compose port'
        alias dkcps='docker compose ps'
        alias dkcr='docker compose run -e COLUMNS=`tput cols` -e LINES=`tput lines`'
        alias dkcR='docker compose run -e COLUMNS=`tput cols` -e LINES=`tput lines` --rm'
        alias dkcrm='docker compose rm'
        alias dkcs='docker compose start'
        alias dkcsc='docker-compose scale'
        alias dkcS='docker compose restart'
        alias dkct='docker compose top'
        alias dkcu='docker compose up'
        alias dkcU='docker compose up -d'
        alias dkcv='docker-compose version'
        alias dkcx='docker compose stop'
    fi

    # Mutagen
    alias mg='mutagen'
    alias mgc='mutagen compose'
    alias mgcb='mutagen compose build'
    alias mgcB='mutagen compose build --no-cache'
    alias mgcd='mutagen compose down'
    alias mgce='mutagen compose exec -e COLUMNS=`tput cols` -e LINES=`tput lines`'
    alias mgck='mutagen compose kill'
    alias mgcl='mutagen compose logs'
    alias mgcL='mutagen compose logs -f'
    alias mgcls='mutagen compose ps'
    alias mgcp='mutagen compose pause'
    alias mgcP='mutagen compose unpause'
    alias mgcpl='mutagen compose pull'
    alias mgcph='mutagen compose push'
    alias mgcps='mutagen compose ps'
    alias mgcr='mutagen compose run -e COLUMNS=`tput cols` -e LINES=`tput lines`'
    alias mgcR='mutagen compose run -e COLUMNS=`tput cols` -e LINES=`tput lines` --rm'
    alias mgcrm='mutagen compose rm'
    alias mgcs='mutagen compose start'
    alias mgcsc='mutagen compose scale'
    alias mgcS='mutagen compose restart'
    alias mgcu='mutagen compose up'
    alias mgcU='mutagen compose up -d'
    alias mgcv='mutagen compose version'
    alias mgcx='mutagen compose stop'

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
    alias grep="grep --color=auto"
    alias ls="ls --color=auto"
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
    #alias 8d="(cd $HOME/git/dotfiles; nvim .)"
    #alias 8dl="(cd $HOME/git/dotfiles/.config/lib; nvim .)"

    #alias ls='exa --icons 2>/dev/null'
    if _has bat; then alias cat='bat --color=always'; fi
    if _has exa; then alias ls='exa --icons'; fi
    #function ls () { if exa --icons $1 2>/dev/null; then else ls --color=auto $1; fi }
    #function cat () { if _has bat; then echo `bat --color=always` $1; else echo `cat $1`; fi }
    #alias cat='bat --color=always {} 2>/dev/null || cat {}'

    alias f="fzf --preview 'cat {}'"
    alias F="fzf --height 100% --preview 'cat {}'"
    alias diff='diff --color'
    alias drive='skicka'
    alias 8gt='git clone git@github.com:Bucchiman/test.git'
    alias 8g='git clone git@github.com:Bucchiman'
    alias 8gd='git clone --recursive git@github.com:Bucchiman/dotfiles'
    alias pass=''
    alias a='alias | fzf --height 100%'
    #alias go8u='rsync -auvz --exclude {'.git','.gitignore'} /mnt/c/Users/yk.iwabuchi/git/dotfiles voyager:git/; rsync -auvz --exclude {'.git','.gitignore'} /mnt/c/Users/yk.iwabuchi/git/dotfiles voyager:git/;'
    #alias bat='bat'

    alias rsync='rsync -arul -vhtp --progress'
    alias rsyncn='rsync -n'
    alias rsum='rsync -c'
    alias rsumn='rsyncn -c'

    alias get_idf='. $HOME/source/esp/esp-idf/export.sh'

}



return
