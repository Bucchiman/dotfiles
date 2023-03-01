# FileName:     Makefile
# Author: 8ucchiman
# CreatedDate:  2023-02-13 20:47:09 +0900
# LastModified: 2023-02-18 11:24:55 +0900
# Reference: 8ucchiman.jp



# static variables
PYTHON_CODES=${HOME}/.config/snippets/codes/python
MAIN=main.py

# dynamic variables 変える必要がある
COMPETITION_ID=747
COMPETITION_NAME=prediction_of_income_from_cencus
BASE_DIR=signate/practice/${COMPETITION_NAME}
DATA_PATH=${HOME}/datas/${BASE_DIR}
TARGET_COL=Y
INDEX_COL=index
PROBLEM_TYPE=Classification
SUBMISSION_FILE=./src/true.csv


.PHONY: all link dataset eda preprocess fitting submission clean help

all:
	cd src; python ${MAIN} --eda --preprocessing --fitting --problem_type ${PROBLEM_TYPE} --target_col ${TARGET_COL} --index_col ${INDEX_COL}

link:
	ln -sf ${DATA_PATH} datas
	ln -sf ${PYTHON_CODES}/eda/eda.py src/
	ln -sf ${PYTHON_CODES}/ml/fitting.py src/
	ln -sf ${PYTHON_CODES}/preprocessing/preprocess.py src/
	ln -sf ${PYTHON_CODES}/utils.py src/

dataset:
	# cd datas; signate download -c ${COMPETITION_ID}
	mkdir -p ${DATA_PATH}; cd ${DATA_PATH}; signate download -c ${COMPETITION_ID}

eda_noshow:
	cd src; python ${MAIN} -e --problem_type ${PROBLEM_TYPE} --target_col ${TARGET_COL} --index_col ${INDEX_COL}

eda_imshow:
	cd src; python ${MAIN} -e --problem_type ${PROBLEM_TYPE} --target_col ${TARGET_COL} --index_col ${INDEX_COL} --imshow

preprocess:
	cd src; python ${MAIN} -p --problem_type ${PROBLEM_TYPE} --target_col ${TARGET_COL} --index_col ${INDEX_COL}

fitting:
	cd src; python ${MAIN} -p -f --problem_type ${PROBLEM_TYPE} --target_col ${TARGET_COL} --index_col ${INDEX_COL}

submission:
	signate submit -c ${COMPETITION_ID} ${SUBMISSION_FILE}

clean:
	rm -r *.png *.pdf *.jpg *.aux *.dvi *.log logs/* src/*.csv src/__pycache__

help:
	cd src; python ${MAIN} --help
