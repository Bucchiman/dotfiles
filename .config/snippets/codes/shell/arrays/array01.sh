#!/bin/zsh
#
# FileName: 	array01
# Author: 8ucchiman
# CreatedDate:  2023-01-24 23:05:54 +0900
# LastModified: 2023-01-24 23:58:27 +0900
# Reference: https://gist.github.com/sho-t/d9cdf8271b3de7c4238739e523490542
#


# 変数確認
export hoge="hello"
echo ${+hoge}     # -> 1
echo ${+geho}     # -> 0


# 値の加工
local -a arr
arr=(Bucchiman 8ucchiman Bucchi)
echo ${arr#B}     # 先頭文字Bの場合削除(要素自体は消さない)
echo ${arr:#Bucchi}   # 完全一致の場合削除
echo "***************"


# 2つの配列の論理 xor
echo 2つの配列の論理 xor
arr=()
arr=(apple potato banana grape chiken)
arrs=(apple banana grape melon)
echo "arr:$arr"
echo "arrs:$arrs"
echo arr\^arrs: ${arr:|arrs}   # arr^arrs -> chiken melon
echo "***************"

# 2つの配列の論理 and
echo 2つの配列の論理 and
arr=()
arr=(apple potato banana grape chiken)
arrs=(apple banana grape melon)
echo "arr:$arr"
echo "arrs:$arrs"
echo arr\&arrs: ${arr:*arrs}   # arr&arrs -> apple banana grape
echo "***************"

# zip
echo zip
a=(a b c); b=(1 2)
echo ${a:^b};         # a 1 b 2
# echo ${a:^^b};      # a 1 b 2 c 1

return
