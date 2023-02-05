#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	preprocess
# Author: 8ucchiman
# CreatedDate:  2023-02-03 21:29:24 +0900
# LastModified: 2023-02-05 15:20:24 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import pandas as pd
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import StratifiedKFold, train_test_split
# import utils


class Preprocessing(object):
    def __init__(self,
                 train_df: pd.DataFrame,
                 test_df: pd.DataFrame,
                 target: str):
        self.train_df = train_df
        self.test_df = test_df
        self.STRATEGY = "median"
        self.target = target

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
        self.label_encoder(label_cols)

    def label_encoder(self, columns):
        for col in columns:
            self.train_df[col] = self.train_df[col].astype(str)
            self.test_df[col] = self.test_df[col].astype(str)
            self.train_df[col] = LabelEncoder().fit_transform(self.train_df[col])
            self.test_df[col] = LabelEncoder().fit_transform(self.test_df[col])

    def cross_validation(self):
        self.train_df.drop(["Name", "Cabin"], axis=1, inplace=True)
        self.test_df.drop(["Name", "Cabin"], axis=1, inplace=True)
        X = self.train_df.drop([self.target], axis=1)
        y = self.train_df[self.target]
        X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=12, test_size=0.33)


    def chomp_outliar(self):
        pass


def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    preprocessing = Preprocessing(pd.read_csv("./datas/train.csv"), pd.read_csv("./datas/test.csv"), "Transported")
    preprocessing.imputer()
    preprocessing.encoding_category()
    preprocessing.cross_validation()


if __name__ == "__main__":
    main()
