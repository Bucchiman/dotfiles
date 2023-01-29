#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	/Users/8ucchiman/git/dotfiles/.config/snippets/codes/python/tables/general
# Author: 8ucchiman
# CreatedDate:  2023-01-28 14:37:22 +0900
# LastModified: 2023-01-28 15:05:21 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
#import utils
import numpy as np
import pandas as pd


def main():
    #args = utils.get_args()
    #method = getattr(utils, args.method)

    train_df = pd.read_csv("hoge.csv")

    train_df.count()        # type(pandas.core.series.Series) 値ありのセル数、カラム別に表示
    train_df.isna().sum()   # type(pandas.core.series.Series) nanのセル数、カラム別に表示

    train_df.describe()     # type(pandas.core.frame.DataFrame) 平均, 標準偏差, 四分位点を表示 -> 分布がわかる


    


if __name__ == "__main__":
    main()
