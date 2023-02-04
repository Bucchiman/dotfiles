#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	main
# Author: 8ucchiman
# CreatedDate:  2023-02-04 12:21:34 +0900
# LastModified: 2023-02-04 12:57:47 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
from pathlib import Path
import utils
from utils import get_args, get_logger
import pandas as pd
from eda import EDA



def main():
    args = get_args()
    logger = get_logger(args.log_file)
    train_df = pd.read_csv(os.path.join(args.data_path, args.train))
    test_df = pd.read_csv(os.path.join(args.data_path, args.test))
    #eda = EDA()
    method = getattr(utils, "make_date_log_directory")
    print(type(method()))
    # train_df = pd.read_csv()




if __name__ == "__main__":
    main()
