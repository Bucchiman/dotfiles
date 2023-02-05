#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	main
# Author: 8ucchiman
# CreatedDate:  2023-02-04 12:21:34 +0900
# LastModified: 2023-02-05 15:35:51 +0900
# Reference: https://www.kaggle.com/code/pmarcelino/comprehensive-data-exploration-with-python
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
    method = getattr(utils, "make_date_log_directory")
    print(method())
    logger = get_logger(args.log_file)
    train_df = pd.read_csv(os.path.join(args.data_path, args.train))
    test_df = pd.read_csv(os.path.join(args.data_path, args.test))
    eda = EDA(train_df, test_df, args.target, logger, args.imshow, args.result_dir)
    eda.column_wise_missing()
    eda.row_wise_missing()
    eda.distribution_of_continuous()
    eda.distribution_of_category()
    eda.correlation_matrix()


if __name__ == "__main__":
    main()
