#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	calculate_pmi
# Author: 8ucchiman
# CreatedDate:  2023-02-18 13:57:27 +0900
# LastModified: 2023-02-18 14:07:15 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
# import utils
# from import utils import get_args, get_logger
import numpy as np
# import pandas as pd


def calculate_ppmi(co_occurence_matrix: np.array, eps=1e-8):
    '''
        positive pmi
        ppmi = max(0, pmi(x, y))
        pmi(x, y) = log2(P(x, y)/P(x)P(y))
                  = log2(C(x, y)N/C(x)C(y))
    '''
    pass




def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    
    pass


if __name__ == "__main__":
    main()
