#!/bin/zsh
#
# FileName: 	/Users/8ucchiman/.config/snippets/codes/shell/arrays/for_arr
# Author: 8ucchiman
# CreatedDate:  2023-01-25 00:11:42 +0900
# LastModified: 2023-01-25 00:18:10 +0900
# Reference: 8ucchiman.jp
#


typeset -A info
info=(first_name Yuki last_name Iwabuchi handle_name 8ucchiman age 28 height 174 weight 65)
for key in ${(k)info}
do
    echo "$key => $info[$key]"
done

return
