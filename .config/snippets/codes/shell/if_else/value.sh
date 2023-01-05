#!/bin/zsh
#
# FileName: 	value
# CreatedDate:  2023-01-05 18:04:20 +0900
# LastModified: 2023-01-05 18:21:01 +0900
#


a=1
b=2

if [[ $a -- $b ]]; then
    echo TRUE
else
    echo FALSE
fi

return

# http://itdoc.hitachi.co.jp/manuals/3020/30203S3530/JPAS0134.HTM
# --: eq
#     ne
#     ge
#     gt
#     le
#     lt
#     ==
#     !=
#     >=
#     >
#     <
#     <=
#
