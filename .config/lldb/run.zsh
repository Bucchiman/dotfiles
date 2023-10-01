#!/bin/zsh
#
# FileName:     run
# Author:       8ucchiman
# CreatedDate:  2023-09-08 16:26:48
# LastModified: 2023-01-23 14:11:45 +0900
# Reference:    8ucchiman.jp
# Description:  ---
#


set -ex        # 途中のエラーで実行中断

function func_lst () {
    echo "***********************************"
    echo "The following function is prepared."
    echo "***********************************"
    cat $0 | awk '/^function/ {printf "| %s\n", $2}'
    echo "***********************************"
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

typset -A SUBMODULES
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



function default () {
    #
    # this is default setting
    # you can run this function without no arguments.
    #
    echo "******************************"
    echo "* default                    *"
    echo "******************************"
    echo "this is default setting"
    echo "you can run this function without no arguments."
    cp lldbinit.py $HOME
    echo "command script import ~lldbinit.py" >>$HOME/.lldbinit
    wget -P ~ https://git.io/.gdbinit
}


#######################################
function main01 () {
    set_viriables
    if [[ $@ == "" ]]; then
        default
    else
        eval $@
    fi

}

ME=$0
main01 $@
#######################################


return

