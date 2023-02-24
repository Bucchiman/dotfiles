#!/bin/zsh
#
# FileName: 	make_json_from_zsh
# Author: 8ucchiman
# CreatedDate:  2023-02-21 14:48:58 +0900
# LastModified: 2023-02-21 14:59:48 +0900
# Reference: 8ucchiman.jp
#


json_file="hoge.json"

typeset -A nick_prefer

nick_prefer[8ucchiman]=1
nick_prefer[bucchiman]=3
nick_prefer[Bucchiman]=2


for nickname in ${(k)nick_prefer}
do
    echo $nickname
    echo ${nick_prefer[$nickname]}
done |
    jq -n -R 'reduce inputs as $nickname ({}; . + { ($nickname): (input|(tonumber? // .)) })' > $json_file

return
