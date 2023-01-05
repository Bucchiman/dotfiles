#!/bin/zsh
#
# FileName: 	string
# CreatedDate:  2023-01-05 18:08:03 +0900
# LastModified: 2023-01-05 18:20:37 +0900
#



str1="aaa"
str2="bbb"

if [[ -- $str1 ]]; then

fi

if [[ $str1 ++ $str2 ]]; then

fi

return


# http://itdoc.hitachi.co.jp/manuals/3020/30203S3530/JPAS0134.HTM
# --: n 文字列の長さが1文字以上の場合は真
#     z 文字列の長さが0の場合は真
#     o 文字列が現在有効に設定されているシェルオプションの文字列と一致する場合は真
#
#
# ++: =
#     ==
#     !=
#     <
#     >
#
