
_usage(){
    echo "Usage: $0 -u username -n image_name -f dockerfile"
    exit 1
}

while getopts :u:n:f: OPT
do
    case $OPT in
        u) username=$OPTARG;;
        n) image_name=$OPTARG;;
        f) dockerfile=$OPTARG;;
        :|\?) _usage;;
    esac
done

docker image build --build-arg USER_NAME=$username \
                   --build-arg USER_ID=$(id -u) \
                   --build-arg GROUP_ID=$(id -g) \
                   -t $username/$image_name -f $dockerfile .

#docker image build -t cheesesan/ros2 -f Dockerfile.ros2 .
