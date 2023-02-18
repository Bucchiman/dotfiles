# FileName:     Makefile
# Author: 8ucchiman
# CreatedDate:  2023-02-18 21:59:34 +0900
# LastModified: 2023-02-18 22:05:42 +0900
# Reference: 8ucchiman.jp


PYTHON_CODES=.config/snippets/codes/python/dl/torch
MAIN=main.py

# 
COMPETITION_NAME=# You can write here
BASE_DIR=path/to/${COMPETITION_NAME}i
DATA_PATH=${HOME}/datas/${BASE_DIR}


.PHONY: clean link


link:
	ln -sf ${HOME}/${PYTHON_CODES}/datasets.py src/
	ln -sf ${HOME}/${PYTHON_CODES}/models.py src/
	ln -sf ${HOME}/${PYTHON_CODES}/train.py src/
	ln -sf ${HOME}/${PYTHON_CODES}/transform.py src/


clean:
	rm *.png *.pdf *.jpg *.aux *.dvi *.log
