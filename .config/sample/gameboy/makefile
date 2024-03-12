#
# FileName:     makefile
# Author:       8ucchiman
# CreatedDate:  2024-03-12 16:03:14
# LastModified: 2024-03-12 16:05:05
# Reference:    https://qiita.com/chibi929/items/b8c5f36434d5d3fbfa4a
# Description:	---
#


.PHONY: clean

hello-world.gb: hello-world.o
	rgblink -o hello-world.gb hello-world.o
	rgbfix -v -p 0xFF hello-world.gb

hello-world.o:
	rgbasm -L -o hello-world.o hello-world.asm


clean:
	rm hello-world.o
