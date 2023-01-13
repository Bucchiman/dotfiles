#!/bin/zsh
#
# FileName: 	extract_string_with_awk
# CreatedDate:  2023-01-12 15:57:54 +0900
# LastModified: 2023-01-12 15:58:51 +0900
#

files=`ls`
target_string="$1"
for fp in $files
do
    awk -v fp=$fp -v ts=$target_string '{printf "%s: %s\n", fp, $0}' $fp
done
return
