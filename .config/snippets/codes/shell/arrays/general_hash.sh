#!/bin/zsh
#
# FileName: 	general_hash
# Author: 8ucchiman
# CreatedDate:  2023-01-28 13:57:32 +0900
# LastModified: 2023-01-28 14:13:07 +0900
# Reference: https://qiita.com/mollifier/items/ba956b7c07acdabd74a7
#


typeset -A info
info=(first_name Yuki \
      last_name Iwabuchi \
      handle_name 8ucchiman \
      age 28 \
      height 174 \
      weight 65)

#値全体の配列表示
echo $info[@] # 
echo $info[*]

echo "$info[@]" # => ""

echo ${(k)info}     # keyを表示
echo ${(v)info}     # value表示
echo ${(kv)info}    # key表示 -> value表示
echo ${#info}       # 要素数表示


unset "info[height]" # 要素の削除

return
