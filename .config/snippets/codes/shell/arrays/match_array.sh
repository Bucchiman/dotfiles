#!/bin/zsh
#
# FileName: 	/home/ykiwabuchi/.config/snippets/codes/shell/arrays/match_array
# Author: 8ucchiman
# CreatedDate:  2023-01-27 15:07:42 +0900
# LastModified: 2023-01-27 15:26:39 +0900
# Reference: 8ucchiman.jp
#


arr3=(aaa bbb1 ccc aaa1 bbb2 aaa33)

echo ${(M)arr3:#aaa*}   # aaaで始まる要素だけを集める
echo ${arr3:#aaa*}      # aaaで始まる要素を取り除く


return
