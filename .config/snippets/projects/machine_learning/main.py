#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	main
# Author: 8ucchiman
# CreatedDate:  2023-02-12 09:21:58 +0900
# LastModified: 2023-02-15 22:21:25 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import utils
from utils import Config
# from import utils import get_args, get_logger
import numpy as np
import pandas as pd
from eda import EDA
from preprocess import Preprocessing
from fitting import Fitting


def main():
    args = utils.get_args()
    params = Config().get_cnf(args.config_dir, args.config_file)["params"]
    logger = utils.get_logger(args.log_file, args.log_dir)
    train_path = os.path.join(args.data_dir, args.train_csv)
    test_path = os.path.join(args.data_dir, args.test_csv)
    target_col = args.target_col
    index_col = args.index_col
    # method = getattr(utils, args.method)
    if args.eda:
        eda = EDA(train_path, test_path, target_col, index_col, logger, results_dir=args.results_dir, imshow=args.imshow)
        # eda.groupby_pivoting(["education-num", "native-country"])
        eda.facetgrid(method="histplot", feature=None, x="age")
        eda.facetgrid(method="histplot", feature="sex", x="workclass")
        # eda.facetgrid(method="histplot", feature="relationship", target=target_col, x="workclass")
        # eda.correlation_matrix()
    if args.preprocessing:
        preprocessing = Preprocessing(train_path, test_path, target_col, index_col, logger)
        preprocessing.replace({"workclass": {"?": "Private"}, "occupation": {"?": "Craft-repair"}})
        preprocessing.label_encoder(columns=["workclass", "education", "occupation", "marital-status", "relationship", "race", "sex", "native-country"])
        X_train, X_valid, y_train, y_valid = preprocessing.get_cross_validation()
        preprocessing.save_DataFrame()
        train_df, test_df = preprocessing.get_preprocess_df()
        logger.info(train_df.head())
        if args.fitting:
            fitting = Fitting(train_df, test_df, target_col, index_col, logger, args.problem_type, params=params)
            fitting.cross_validation(X_train, X_valid, y_train, y_valid)
            # fitting.kfold_cross_validation()
            # fitting.base_models("RandomForestClassifier")
            # fitting.base_models("ExtraTreesClassifier")
            # fitting.base_models("AdaBoostClassifier")
            # fitting.base_models("GradientBoostingClassifier")
            # fitting.base_models("SVC")
            fitting.base_models("LGBMClassifier")
            # fitting.lightgbm()
            # fitting.submission()


if __name__ == "__main__":
    main()
