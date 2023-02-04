#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	learn
# Author: 8ucchiman
# CreatedDate:  2023-02-04 11:35:39 +0900
# LastModified: 2023-02-04 12:31:57 +0900
# Reference: 8ucchiman.jp
#


import os
import sys

# import utils
# import numpy as np
# import pandas as pd


class Learn_Model(object):
    def __init__(self):
        self.clf = LazyClassifier(verbose=0,
                                  ignore_warnings=True,
                                  custom_metric=None,
                                  predictions=False,
                                  random_state=12,
                                  classifiers='all')

    def run(self):
        models, predictions = clf.fit(X_train, X_test, y_train, y_test)




def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    


if __name__ == "__main__":
    main()
