#!/bin/zsh
#
# FileName: 	run
# CreatedDate:  2023-01-16 14:04:54 +0900
# LastModified: 2023-02-07 10:23:53 +0900
#


function _usage() {
    echo "Usage: $0 -m max_process"
    exit 1
}

if [[ $# = 0 ]]
then
    echo No arguments or options
    exit 1
fi

while getopts :m:f: OPT
do
    case $OPT in
        m) max_process=$OPTARG;;
        f) run_file=$OPTARG;;
        :|\?) _usage;;
    esac
done

date "+%Y_%m_%d_%H_%M"
run_sh=""
bus_ids=(`lshw -C display -businfo 2>/dev/null | grep pci | cut -d : -f 2`)
# bus_process連想配列の初期化 key: bus_id, value: num_process
typeset -A bus_process
for bi in $bus_ids
do
  bus_process[$bi]=0
done

num_running_process=(`nvidia-smi --query-compute-apps=gpu_bus_id --format=csv,noheader`)
for idx in {1..${#num_running_process}}
do
  id=`echo $num_running_process[$idx] | cut -d : -f 2`
  bus_process[$id]=$(($bus_process[$id]+1))
done
echo $bus_process

i=0
for bp in ${(k)bus_process}
do
  if [[ $bus_process[$bp] < $max_process ]]
  then
    export CUDA_VISIBLE_DEVICES=$i
    ./${run_file}
    bus_process[$bp]=$((bus_process[$bp]+1))
  fi
  i=$((i+1))
done

return
