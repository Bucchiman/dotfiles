#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	decisiontree
# Author: 8ucchiman
# CreatedDate:  2023-02-06 16:15:49 +0900
# LastModified: 2023-02-06 16:17:29 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
from sklearn.tree import DecisionTreeClassifier
# import utils
# from import utils import get_args, get_logger
# import numpy as np
# import pandas as pd


def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    X = [[0, 0], [1, 1]]
    Y = [0, 1]
    clf = DecisionTreeClassifier()
    clf = clf.fit(X, Y)


if __name__ == "__main__":
    main()
