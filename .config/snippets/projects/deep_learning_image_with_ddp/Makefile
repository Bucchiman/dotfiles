# FileName:     Makefile
# Author: 8ucchiman
# CreatedDate:  2023-02-18 21:59:34 +0900
# LastModified: 2023-02-22 11:58:24 +0900
# Reference: 8ucchiman.jp


PYTHON_CODES=.config/snippets/codes/python
MAIN=main.py

# 
COMPETITION_NAME=# You can write here
#BASE_DIR=path/to/${COMPETITION_NAME}
BASE_DIR=nishika/practice/emakimono_ehon
DATA_PATH=${HOME}/datas/${BASE_DIR}


.PHONY: clean link cp run

run:
	cd src; python main.py --train_img_dir train --test_img_dir test --train_label_file train.csv


dataset:
	ln -sf ${DATA_PATH} datas


link:
	ln -sf ${HOME}/${PYTHON_CODES}/dl/torch/datasets.py src/
	ln -sf ${HOME}/${PYTHON_CODES}/dl/torch/models.py src/
	ln -sf ${HOME}/${PYTHON_CODES}/dl/torch/train.py src/
	ln -sf ${HOME}/${PYTHON_CODES}/dl/torch/transform.py src/
	ln -sf ${HOME}/${PYTHON_CODES}/utils.py src/

cp:
	cp ${HOME}/${PYTHON_CODES}/dl/torch/datasets.py src/
	cp ${HOME}/${PYTHON_CODES}/dl/torch/models.py src/
	cp ${HOME}/${PYTHON_CODES}/dl/torch/train.py src/
	cp ${HOME}/${PYTHON_CODES}/dl/torch/transform.py src/
	cp ${HOME}/${PYTHON_CODES}/utils.py src/


clean:
	rm *.png *.pdf *.jpg *.aux *.dvi *.log
