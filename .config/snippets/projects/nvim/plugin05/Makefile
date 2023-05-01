#
# FileName:     Makefile
# Author: 		8ucchiman
# CreatedDate:  2023-05-01 10:35:00
# LastModified: 2023-02-03 21:27:40 +0900
# Reference: 	https://qiita.com/chibi929/items/b8c5f36434d5d3fbfa4a
# Description:	---
#


TESTS_INIT=tests/init.lua
TEST_DIR=tests/


.PHONY: test rename

test:
	@nvim --headless \
		  --noplugin \
		  -u ${TESTS_INIT} \
		  -c "PlenaryBustedDirectory ${TEST_DIR} {minimal_init = '${TESTS_INIT}'}"


rename:
	find -type f * | xargs sed -i".org" 's/_plugin_name/bucchiman/g'

redo:
	
