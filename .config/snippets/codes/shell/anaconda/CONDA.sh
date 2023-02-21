#!/bin/zsh
#
# FileName: 	CONDA
# Author: 8ucchiman
# CreatedDate:  2023-02-20 17:02:13 +0900
# LastModified: 2023-02-21 14:33:56 +0900
# Reference: 8ucchiman.jp
#


function _usage() {
  echo "Usage: $0 -n env_name"
  exit 1
}

while getopts :n: OPT
do
  case $OPT in
    n) env_name=$OPTARG;;
    :|\?) _usage;;
done


if [[ -e $HOME/anaconda3/etc/profile.d/conda.sh ]]
then
  source $HOME/anaconda3/etc/profile.d/conda.sh
fi


function create_env() {
  conda create -n $env_name -y
}

function install_packages() {
  conda activate $env_name
  conda update --all
  conda install numpy -y 
  conda install -c conda-forge matplotlib -y
  conda install -c conda-forge seaborn -y
}

function remove_env() {
  conda remove -n $env_name --all -y
}

return
