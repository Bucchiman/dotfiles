#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	utils
# CreatedDate:  2023-01-06 11:00:12 +0900
# LastModified: 2023-01-10 21:23:05 +0900
#


import os
import sys
import argparse
import logging
from logging import getLogger, config


def get_logger(log_name):
    logging.basicConfig(level=logging.INFO)
    logger = logging.getLogger()
    logger.setLevel(logging.INFO)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    log_file = os.path.join("logs", log_name)
    file_handler = logging.FileHandler(log_file)
    file_handler.setLevel(logging.INFO)
    file_handler.setFormatter(formatter)
    logger.addHandler(file_handler)
    logger.info("Log file is %s." % log_file)
    return logger


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument()
    args = parser.parse_args()


def main():
    logger = get_logger("hoge.log")
    logger.info("hello")


if __name__ == "__main__":
    main()
