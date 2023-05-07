#
# FileName:     Makefile
# Author: 		8ucchiman
# CreatedDate:  2023-05-01 10:35:00
# LastModified: 2023-02-03 21:27:40 +0900
# Reference: 	https://qiita.com/chibi929/items/b8c5f36434d5d3fbfa4a
#               https://qiita.com/algas/items/499d0d69d51a1cc7639f
# Description:	---
#


TESTS_INIT=tests/init.lua
TEST_DIR=tests/
files=$(shell fd --type f _plugin_name)
dirs=$(shell fd --type d _plugin_name)


.PHONY: test rename

test:
	@nvim --headless \
		  --noplugin \
		  -u ${TESTS_INIT} \
		  -c "PlenaryBustedDirectory ${TEST_DIR} {minimal_init = '${TESTS_INIT}'}"


rename:
	fd --type f -e lua | xargs sed -i '' "s/_plugin_name/$(ARG)/g"
	mv lua/_plugin_name lua/$(ARG)
	mv lua/_plugin_name.lua lua/$(ARG).lua
	mv plugin/_plugin_name.lua plugin/$(ARG).lua
	mv tests/_plugin_name tests/$(ARG)
	mv tests/$(ARG)/_plugin_name_spec.lua tests/$(ARG)/$(ARG)_spec.lua

redo:
	fd --type f -e lua | xargs sed -i "s/$(ARG)/_plugin_name/g"


echo:
	@echo "$(ARG)"
