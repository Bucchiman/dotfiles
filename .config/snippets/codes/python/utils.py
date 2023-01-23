#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	utils
# CreatedDate:  2023-01-06 11:00:12 +0900
# LastModified: 2023-01-21 20:47:16 +0900
#


import os
import sys
import argparse
import logging
from logging import getLogger, config
from datetime import datetime


def get_logger(log_dir, file_name):
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
    #parser.add_argument()
    parser.add_argument('--strlist', required=True, nargs="*", type=str, help='a list of strings') # --strlist hoge fuga geho
    parser.add_argument('--method', type=str)
    parser.add_argument('--fruit', type=str, default='apple', choices=['apple', 'banana'], required=True)
    parser.add_argument('--address', type=lambda x: list(map(int, x.split('.'))), help="IP address") # --address 192.168.31.150 --> [192, 168, 31, 150]
    parser.add_argument('--colors', nargs='*', required=True)
    args = parser.parse_args()
    return args


def main():
    '''
    logger = get_logger("./logs", "hoge.log")
    logger.info("hello")
    '''
    pass


if __name__ == "__main__":
    main()
