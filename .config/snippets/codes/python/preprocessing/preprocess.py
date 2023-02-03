#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	preprocess
# Author: 8ucchiman
# CreatedDate:  2023-02-03 21:29:24 +0900
# LastModified: 2023-02-03 23:36:40 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import pandas as pd
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import LabelEncoder
# import utils


class Preprocessing(object):
    def __init__(self, train_df, test_df):
        self.train_df = train_df
        self.test_df = test_df
        self.STRATEGY = "median"

    def imputer(self):
        imputer_cols = ["Age", "FoodCourt", "ShoppingMall",
                        "Spa", "VRDeck" ,"RoomService"]
        imputer = SimpleImputer(strategy=self.STRATEGY)
        imputer.fit(self.train_df[imputer_cols])
        self.train_df[imputer_cols] = imputer.transform(self.train_df[imputer_cols])
        self.test_df[imputer_cols] = imputer.transform(self.test_df[imputer_cols])
        self.train_df["HomePlanet"].fillna('Z', inplace=True)
        self.test_df["HomePlanet"].fillna('Z', inplace=True)

    def encoding_category(self):
        label_cols = ["HomePlanet", "CryoSleep",
                      "Cabin", "Destination", "VIP"]
        train, test = self.label_encoder(self.train_df,
                                         self.test_df,
                                         label_cols)

    def label_encoder(self, train, test, columns):
        for col in columns:
            train[col] = train[col].astype(str)
            test[col] = test[col].astype(str)
            train[col] = LabelEncoder().fit_transform(train[col])
            test[col] =  LabelEncoder().fit_transform(test[col])
        return train, test


def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    preprocessing = Preprocessing(pd.read_csv("./datas/train.csv"), pd.read_csv("./datas/test.csv"))
    preprocessing.imputer()
    preprocessing.encoding_category()


if __name__ == "__main__":
    main()
