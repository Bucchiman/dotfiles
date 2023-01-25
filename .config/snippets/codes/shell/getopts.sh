#!/bin/zsh
#
# FileName: 	getopts
# CreatedDate:  2023-01-05 17:55:19 +0900
# LastModified: 2023-01-25 15:51:12 +0900
#

function _usage() {
    echo "Usage: $0 -u username -n image_name -f dockerfile"
    exit 1
}

if [[ $# = 0 ]]
then
    echo No arguments or options
    exit 1
fi

while getopts :ab:c: OPT
do
    case $OPT in
        a) flag=1;;
        b) b=$OPTARG;;
        c) c=$OPTARG;;
        :|\?) _usage;;
    esac
done
if [[ ! -z $flag ]]
then
    printf "stand flag\n"
fi

return

#
# a:bc:
# -> aとcオプションは引数
# -> command -a hoge -b -c geho
# :a:bc:
# -> 未定義オプションの場合、?として処理
#

