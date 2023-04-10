nohup socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\" &

docker build -t mac_x11 -f Mac_X11.Dockerfile .
docker run -it --rm -e DISPLAY=docker.for.mac.host.internal:0 mac_x11
