#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	/home/ykiwabuchi/.config/snippets/codes/python/ml/pandas
# Author: 8ucchiman
# CreatedDate:  2023-02-03 16:44:18 +0900
# LastModified: 2023-02-03 17:13:34 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import pandas as pd
# import utils



def extract_from_df(df: pd.DataFrame , operation: str):
    '''
        query('customer_id == "CS09"')
        query('customer_id == "CS09" and amount >= 100')
        query('customer_id == "CS09" and (amount >= 100 or quantity >=5)')
        query('customer_id == "CS09" and product_cd != "P081"')
        query("store_cd.str.startswith('S14')", engine='python')
        query("store_cd.str.startswith('S14')") これでもOK
        query("store_cd.str.endswith('1')")
        query("address.str.contains('横浜')")
        query("address.str.contains(r'^[A-F]')")        A~Fで始まるデータ
        query("address.str.contains(r'[1-9]$')")        1~9で終わるデータ
        query("address.str.contains(r'^[A-F].*[1-9]$')")
        query("address.str.contains(r'^[0-9]{3}-[0-9]{3}-[0-9]{4}'$)")      080-802-2224
    '''
    df.query(operation)


def sort_values(df: pd.DataFrame, column: str):
    df.sort_values(column)


def aggregate(df):


def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    


if __name__ == "__main__":
    main()
