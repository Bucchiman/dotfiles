#!/bin/zsh
#
# FileName: 	file
# CreatedDate:  2023-01-05 18:13:37 +0900
# LastModified: 2023-01-05 18:20:03 +0900
#


fp="$HOME/script/test"

if [[ -- $fp ]]; then
fi


return


# http://itdoc.hitachi.co.jp/manuals/3020/30203S3530/JPAS0134.HTM
# --: a fileが存在する場合は真
#     d ディレクトリの場合は真
#     e fileが存在する場合は真
#     h fileが存在し、シンボリックリンクの場合は真
#     s ファイルが存在し、ファイルサイズが１以上の場合は真
#
