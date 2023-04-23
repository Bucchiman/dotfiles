#!/bin/zsh
#
# FileName:     {{_file_name_}}
# Author:       {{_author_}}
# CreatedDate:  {{_date_}}
# LastModified: 2023-01-23 14:12:50 +0900
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


{{_cursor_}}


return
