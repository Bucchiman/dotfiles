#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	preprocess
# Author: 8ucchiman
# CreatedDate:  2023-02-03 21:29:24 +0900
# LastModified: 2023-02-15 15:07:40 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import re
import logging
import pandas as pd
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import StratifiedKFold, train_test_split
# import utils


class Preprocessing(object):
    def __init__(self,
                 train_path: str,
                 test_path: str,
                 target: str,
                 index: str,
                 logger: logging.RootLogger,
                 save_csv_dir="../preprocessed"):
        self.train_df = pd.read_csv(train_path)
        self.test_df = pd.read_csv(test_path)
        # self.train_df = self.train_df.rename(columns=lambda x:re.sub('[^A-Za-z0-9_]+', '', x))
        # self.test_df = self.test_df.rename(columns=lambda x:re.sub('[^A-Za-z0-9_]+', '', x))
        self.STRATEGY = "median"
        self.target = target
        self.index = index
        self.logger = logger
        self.save_csv_dir = save_csv_dir

    def imputer(self):
        imputer_cols = ["Age", "FoodCourt", "ShoppingMall",
                        "Spa", "VRDeck", "RoomService"]
        imputer = SimpleImputer(strategy=self.STRATEGY)
        imputer.fit(self.train_df[imputer_cols])
        self.train_df[imputer_cols] = imputer.transform(self.train_df[imputer_cols])
        self.test_df[imputer_cols] = imputer.transform(self.test_df[imputer_cols])
        self.train_df["HomePlanet"].fillna('Z', inplace=True)
        self.test_df["HomePlanet"].fillna('Z', inplace=True)

    def label_encoder(self, columns: list[str]):
        '''
            カテゴリカラムについての自動的ラベルづけ
            columns: カテゴリカラム
        '''
        for col in columns:
            self.train_df[col] = self.train_df[col].astype(str)
            self.test_df[col] = self.test_df[col].astype(str)
            self.train_df[col] = LabelEncoder().fit_transform(self.train_df[col])
            self.test_df[col] = LabelEncoder().fit_transform(self.test_df[col])

    def get_cross_validation(self):
        X = self.train_df.drop([self.index, self.target], axis=1)
        y = self.train_df[self.target]
        # X_train, X_test, y_train, y_test = train_test_split(X, y, random_state=12, test_size=0.33)
        return train_test_split(X, y, random_state=12, test_size=0.33)

    def chomp_outliar(self):
        pass

    def drop_column(self, features: list[str]):
        self.train_df.drop(features, axis=1, inplace=True)
        self.test_df.drop(features, axis=1, inplace=True)

    def save_DataFrame(self):
        self.train_df.to_csv(os.path.join(self.save_csv_dir, "preprocessing_train.csv"))
        self.test_df.to_csv(os.path.join(self.save_csv_dir, "preprocessing_test.csv"))

    def get_preprocess_df(self):
        return self.train_df, self.test_df

    def replace(self, operation: dict[str: dict[any: any]]):
        self.train_df.replace(operation, inplace=True)
        self.test_df.replace(operation, inplace=True)

    def completing_category(self, feature: str, method: str = "mode"):
        '''
            欠損値補完
            method = mode
                最頻値
        '''
        if method == "mode":
            freq_value = self.train_df[feature].dropna().mode()[0]
            self.train_df[feature] = self.train_df[feature].fillna(freq_value)
            self.test_df[feature] = self.test_df[feature].fillna(freq_value)

    def completing_continuous(self):
        pass




def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    # preprocessing = Preprocessing(pd.read_csv("./datas/train.csv"), pd.read_csv("./datas/test.csv"), "Transported")
    # preprocessing.imputer()
    # preprocessing.encoding_category()
    # preprocessing.cross_validation()
    pass


if __name__ == "__main__":
    main()
