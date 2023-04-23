#
# FileName:     {{_file_name_}}
# Author: 		{{_author_}}
# CreatedDate:  {{_date_}}
# LastModified: 2023-02-03 21:27:40 +0900
# Reference: 	8ucchiman.jp
# Description:	---
#


{{_cursor_}}


# 静的ライブラリ作成
static: *.o
	ar rvs libhoge.a geho.o

# 共有ライブラリ作成
dynamic: *.o
	g++ -shared hoge.o -o libhoge.so


.PHONY: clean
clean:
	rm *.png *.pdf *.jpg *.aux *.dvi *.log
