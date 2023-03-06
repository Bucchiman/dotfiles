CC=g++
CPP_files=hoge.cpp

run:
	${CC} -I/usr/include/opencv4 -o a.out ${CPP_files} -lopencv_core -lopencv_highgui -lopencv_imgcodecs
