#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	utils
# CreatedDate:  2023-01-06 11:00:12 +0900
# LastModified: 2023-02-04 13:20:58 +0900
#


import os
import sys
import argparse
import logging
from logging import getLogger, config
from datetime import datetime
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt


def get_logger(file_name, log_dir="logs"):
    os.makedirs(log_dir, exist_ok=True)
    log_path = os.path.join(log_dir, file_name)

    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    file_handler = logging.FileHandler(log_path)
    file_handler.setLevel(logging.INFO)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    logger.info("Log file is %s." % log_path)
    return logger


def make_date_log_directory():
    return datetime.now().strftime(r"%Y_%m_%d_%H_%M")


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('data_path', default="data", help="data path")
    parser.add_argument('--log_file', default=make_date_log_directory(), help="log file")
    parser.add_argument('--train', default="train.csv", type=str, help="csv file about train")
    parser.add_argument('--test', default="test.csv", type=str, help="csv file about test")
    parser.add_argument('--target', type=str, help="fitting target", required=True)
    parser.add_argument('--result_dir', default="results", type=str, help="images and model about eda, fitting...")
    args = parser.parse_args()
    return args


def make_barplot():
    x = np.arange()
    x_position = np.arange(len(x))
    y_one = np.array()
    y_two = np.array()
    fig = plt.figure()
    ax = fig.add_subplot(1, 1, 1)
    ax.bar(x_position, y_one, width=0.2, label="one")
    ax.bar(x_position+0.2, y_two, width=0.2, label="two")
    ax.legend()
    ax.set_xticks(x_position+0.2)
    ax.set_xticklabels(x)
    plt.show()
    # parser.add_argument('--colors', nargs='*', required=True)
    fig.savefig("output.png")


def main():
    '''
    args = get_args()
    logger = get_logger(args.log_file)
    logger.info("hello")
    '''
    pass


if __name__ == "__main__":
    main()
