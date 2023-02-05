#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	learn
# Author: 8ucchiman
# CreatedDate:  2023-02-04 11:35:39 +0900
# LastModified: 2023-02-05 21:26:53 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
from lazypredict.Supervised import LazyRegressor
# import utils
# import numpy as np
# import pandas as pd


class Fitting_Model(object):
    def __init__(self, X_train, X_test, y_train, y_test):
        self.X_train = X_train
        self.X_test = X_test
        self.y_train = y_train
        self.y_test = y_test
        self.clf = LazyRegressor(verbose=0,
                                 ignore_warnings=True,
                                 custom_metric=None,
                                 random_state=12,)

    def run(self):
        models, predictions = self.clf.fit(self.X_train, self.X_test, self.y_train, self.y_test)




def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    pass
    


if __name__ == "__main__":
    main()
