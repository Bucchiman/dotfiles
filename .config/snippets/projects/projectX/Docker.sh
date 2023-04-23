#!/bin/zsh
#
# FileName:     Docker
# Author:       8ucchiman
# CreatedDate:  2023-04-23 13:36:26
# LastModified: 2023-01-23 14:11:45 +0900
# Reference:    8ucchiman.jp
#


function _usage() {
}


while getopts :i:c:g OPT
do
    case $OPT in
        i) image_name=$OPTARG;;
        g) gpu_flag=true;;
        c) container_name=$OPTARG;;
        :|\?) _usage;;
    esac
done





return

