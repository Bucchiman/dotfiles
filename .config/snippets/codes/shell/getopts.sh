#!/bin/zsh
#
# FileName: 	getopts
# CreatedDate:  2023-01-05 17:55:19 +0900
# LastModified: 2023-01-05 17:56:12 +0900
#

function _usage() {
    echo "Usage: $0 -u username -n image_name -f dockerfile"
    exit 1
}

while getopts :u:n:f: OPT
do
    case $OPT in
        u) username=$OPTARG;;
        n) image_name=$OPTARG;;
        f) dockerfile=$OPTARG;;
        :|\?) _usage;;
    esac
done

return

#
# a:bc:
# -> aとcオプションは引数
# :a:bc:
# -> 未定義オプションの場合、?として処理
#

