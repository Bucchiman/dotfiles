#!/bin/zsh
#
# FileName: 	run_conda
# Author: 8ucchiman
# CreatedDate:  2023-01-23 17:02:44 +0900
# LastModified: 2023-01-23 17:04:21 +0900
# Reference: 8ucchiman.jp
#


if [[ -e $HOME/anaconda3/etc/profile.d/conda.sh ]]
then
    source $HOME/anaconda3/etc/profile.d/conda.sh
fi
#conda info -e


return
