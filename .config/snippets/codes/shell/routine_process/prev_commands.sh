#!/bin/zsh
#
# FileName: 	prev_commands
# Author: 8ucchiman
# CreatedDate:  2023-02-07 14:58:51 +0900
# LastModified: 2023-02-07 15:28:04 +0900
# Reference: 8ucchiman.jp
#


local -a prev_commands
ps f -o command -p `lsof -n -w -t /dev/nvidia*` | awk 'NR>1 {print $0}' | while read line
do
    prev_commands+=(\"$line\")
done
echo $prev_commands


return
