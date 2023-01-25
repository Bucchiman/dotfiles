#!/bin/zsh
#
# FileName: 	create_periodic_process
# Author: 8ucchiman
# CreatedDate:  2023-01-25 15:07:00 +0900
# LastModified: 2023-01-25 17:38:27 +0900
# Reference: 8ucchiman.jp
#


function _usage() {
    echo "Usage: $0 -s service_name -l log_date"
    exit 1
}
if [[ ! $# = 4 ]]
then
    _usage
    exit 1
fi

while getopts :s:l: OPT
do
    case $OPT in
        s) service_name=$OPTARG;;
        l) log_date=$OPTARG;;
        :|\?) _usage;;
    esac
done

systemctl edit --user --force --full "${service_name}@${log_date}.service"
systemctl --user start "${service_name}@${log_date}.service"
systemctl --user status "${service_name}@${log_date}.service"
systemctl edit --user --force --full "${service_name}.timer"
systemctl --user start "${service_name}.timer"
systemctl --user status "${service_name}.timer"
systemctl --user enable "${service_name}.timer"

return
