#
# FileName:     makefile
# Author:       8ucchiman
# CreatedDate:  2024-03-12 16:03:14
# LastModified: 2024-03-15 09:19:12
# Reference:    
#				https://github.com/ITAYC0HEN/A-journey-into-Radare2/blob/master/Generic/Reversing%20Gameboy%20ROM/simple.gb
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
