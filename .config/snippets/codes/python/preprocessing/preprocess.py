#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	preprocess
# Author: 8ucchiman
# CreatedDate:  2023-02-03 21:29:24 +0900
# LastModified: 2023-02-19 23:08:43 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import re
import logging
import pandas as pd
from sklearn.impute import SimpleImputer
from sklearn.preprocessing import LabelEncoder, StandardScaler, MinMaxScaler, PowerTransformer
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

    def clipping(self, features: list[str], lower: float, upper: float):
        p01 = self.train_df.quantile(lower)
        p99 = self.train_df.quantile(upper)
        self.train_df[features] = self.train_df[features].clip(p01, p99, axis=1)
        self.test_df[features] = self.test_df[features].clip(p01, p99, axis=1)


class Missing_Values(object):
    def __init__(self):
        pass

    def identity(self, features: list[str]):
        """
            欠損値のまま扱う
            何らかの理由で欠損している場合、特徴量として使えるためその情報を捨てるのはもったいない
            * ランダムフォレストでは欠損値を扱えない
              その場合、欠損値に-9999などの通常とりえる範囲外の値を代入すればよい
              こうした処理ができるのはその値自体に意味があるのではなく、相対的な値の比較によって木が
              学習されるからである
        """
        pass

    def completion_typical_value(self, features: list[str], method: str):
        """
            平均: 正規分布
            中央値: 年収などの歪みがある分布
            others: 対数変換後、歪みの少ない分布にしてから平均値をとる
                    全データの平均にする必要はない 別カテゴリ変数の値でグループ分けしたのち平均とするのも可能
                                                   この場合、データ数が少なければ平均値が信用できない場合もある
                                                   この場合、Bayesian averageという手法がある
            最頻値: カテゴリ変数の場合
        """
        pass

    def predict_missing_col_from_others(self):
        """
            欠損値があるカラムについて欠損値なしのカラムを元に予測する
        """
        pass

    def create_feature_from_missing_values(self):
        """
            欠損値である理由が何かしらある場合、その情報を捨てるのはもったいないので
            欠損があるかどうかを新たにカラムに付与すればよい
            欠損しているカラムを補完した場合でもその情報を残すことができる
        """
        pass


class Transform(object):
    """
        変換
    """
    def __init__(self, train_df: pd.DataFrame, test_df: pd.DataFrame):
        self.train_df = train_df
        self.test_df = test_df

    def standard_scaler(self, features: list[str]):
        """
            標準化(平均0, 標準偏差1)
            x' = (x-μ)/σ

            e.g. 線形回帰, ロジスティック回帰ではスケールが大きいほど回帰係数は小さくなる
                 ニューラルネットワークでも同様

            * 0, 1のような二値変数の場合、0, 1の割合が偏っている場合には標準偏差が小さいため、
              二値変数では標準化しなくてよい

        """
        scaler = StandardScaler()
        scaler.fit(self.df[features])
        self.train_df[features] = scaler.transform(self.train_df[features])
        self.test_df[features] = scaler.transform(self.test_df[features])
        pass


    def min_max_scaler(self, features: list[str]):
        """
            x' = (x-x_{min})/(x_{max}-x_{min})
            変換後の平均がちょうど0にならない、外れ値の影響を受けることからStandarScalerのほうがより一般的
            * 画像では0~255ともともと範囲が決まっている変数なのでMin-Maxスケーリングが用いられる
        """
        scaler = MinMaxScaler()
        scaler.fit(self.train_df[features])
        self.train_df[features] = scaler.transform(self.train_df[features])
        self.test_df[features] = scaler.transform(self.test_df[features])
        pass

    def log_transform(self):
        """
            * 非線形変換
            一方向に裾が伸びた分布(金額、カウント)では対数変換が有効
            発散を避けるため log(x+1)変換がよく用いられる(np.log1p)
            負の値についてlog(x)は適応できないのでlog(|x|) -> np.sign(x)*log(|x|)

        """
        pass

    def power_transform(self, features: list[str], method: str = "box-cox"):
        """
            Box-Cox

                   - (x^λ-1)/λ if λ not 0
            x^λ =
                   - log(x)
            Args
                features: 正の値をとるカラムのみ有効
                method: "box-cox"

            Yeo-Johnson
            Args
                features:
                method: "yeo-johnson"

        """
        pt = PowerTransformer(method=method)
        pt.fit(self.train_df[features])

        self.train_df[features] = pt.transform(self.train_df[features])
        self.test_df[features] = pt.transform(self.test_df[features])




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
