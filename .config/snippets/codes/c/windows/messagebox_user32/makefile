SHELL := powershell.exe
.SHELLFLAGS := -NoProfile -Command
LIBRARY := User32.lib
.PHONY: clean all

sample01: messagebox_sample01.c
	cl -EHsc -Fe:$@ $< ${LIBRARY}

sample02: messagebox_sample02.c
	cl -EHsc -Fe:$@ $< ${LIBRARY}

sample03: messagebox_sample03.c
	cl -EHsc -Fe:$@ $< ${LIBRARY}

sample04: messagebox_sample04.c
	cl -EHsc -Fe:$@ $< ${LIBRARY}


clean:
	rm *.exe, *.obj
