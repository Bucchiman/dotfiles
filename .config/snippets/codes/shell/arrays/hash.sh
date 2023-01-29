#!/bin/zsh
#
# FileName: for_loop_hash
# Author: 8ucchiman
# CreatedDate:  2023-01-25 00:11:42 +0900
# LastModified: 2023-01-28 13:56:37 +0900
# Reference: 8ucchiman.jp
#


typeset -A info
info=(first_name Yuki last_name Iwabuchi handle_name 8ucchiman age 28 height 174 weight 65)
for key in ${(k)info}
do
    echo "$key => $info[$key]"
done

return
