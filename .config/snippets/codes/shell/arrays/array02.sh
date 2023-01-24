#!/bin/zsh
#
# FileName: 	array02
# Author: 8ucchiman
# CreatedDate:  2023-01-24 23:58:31 +0900
# LastModified: 2023-01-25 00:10:01 +0900
# Reference: https://qiita.com/mollifier/items/ba956b7c07acdabd74a7
#


typeset -A arr
# local -A arr
arr=(id 28 name 8ucchiman address Ishikawa)
echo $arr[@]        # -> Ishikawa 8ucchiman 28

echo ${(k)arr}          # key print   -> address name id
echo ${(v)arr}          # value print -> Ishikawa 8ucchiman 28
echo ${(kv)arr}

for key in ${(k)arr}
do
    echo "$key => $arr[$key]"
done


if [[ -n "${arr[(i)id]}" ]]
then
    echo "contains"
else
    echo "No"
fi


return
