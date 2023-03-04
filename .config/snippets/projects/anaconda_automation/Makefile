# FileName:     Makefile
# Author: 8ucchiman
# CreatedDate:  2023-02-20 14:02:46 +0900
# LastModified: 2023-02-21 14:40:05 +0900
# Reference: 8ucchiman.jp



SHELL:=/bin/zsh
ENV_NAME=ConfuciuxEnv
CONDA_SHELL=./scripts/CONDA.sh

.PHONY: clean env dataset


all: env dataset


env:
	source ${CONDA_SHELL} && create_env ${ENV_NAME}
	source ${CONDA_SHELL} && install_packages ${ENV_NAME}

dataset:
	mkdir datas/

clean:
	source ${CONDA_SHELL} && remove_env ${ENV_NAME}
	rm -r src/__pycache__ outputs/
