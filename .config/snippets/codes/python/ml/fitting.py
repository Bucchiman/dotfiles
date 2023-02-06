#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	learn
# Author: 8ucchiman
# CreatedDate:  2023-02-04 11:35:39 +0900
# LastModified: 2023-02-06 14:48:50 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import numpy as np
from lazypredict.Supervised import LazyRegressor
from sklearn.linear_model import ElasticNet, Lasso, BayesianRidge, LassoLarsIC
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.kernel_ridge import KernelRidge
from sklearn.preprocessing import RobustScaler
from sklearn.base import BaseEstimator, TransformerMixin, RegressorMixin, clone
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import KFold, cross_val_score
from sklearn.metrics import mean_squared_error
import xgboost as xgb
import lightgbm as lgb
# import utils


class Fitting(object):
    def __init__(self, train_df, test_df, target, logger):
        self.train_df = train_df
        self.test_df = test_df
        self.target = target
        self.logger = logger
        self.X = self.train_df.drop([self.target], axis=1)
        self.y = self.train_df[self.target]

    def single_cross_validation(self, X_train, X_test, y_train, y_test):
        self.X_train = X_train
        self.X_test = X_test
        self.y_train = y_train
        self.y_test = y_test

    def run(self):
        pass

    def lazypredict(self):
        clf = LazyRegressor(verbose=0,
                            ignore_warnings=True,
                            custom_metric=None,
                            random_state=12,)

        models, predictions = clf.fit(self.X_train, self.X_test, self.y_train, self.y_test)

    def kfold_cross_validation(self):
        self.kf = KFold(n_splits=5, shuffle=True, random_state=42).get_n_splits(self.train_df.values)
        self.logger.info("{}".format(self.kf))

    def rmsle_cv(self, model):
        rmse = np.sqrt(-cross_val_score(model, self.X, self.y, scoring="neg_mean_squared_error", cv=self.kf))
        return rmse


    def base_models(self):
        lasso = make_pipeline(RobustScaler(), Lasso(alpha=0.0005, random_state=1))
        ENet = make_pipeline(RobustScaler(), ElasticNet(alpha=0.0005, l1_ratio=.9, random_state=3))
        KRR = KernelRidge(alpha=0.6, kernel='polynomial', degree=2, coef0=2.5)
        GBoost = GradientBoostingRegressor(n_estimators=3000, learning_rate=0.05,
                                           max_depth=4, max_features='sqrt',
                                           min_samples_leaf=15, min_samples_split=10, 
                                           loss='huber', random_state =5)
        model_xgb = xgb.XGBRegressor(colsample_bytree=0.4603, gamma=0.0468, 
                                     learning_rate=0.05, max_depth=3, 
                                     min_child_weight=1.7817, n_estimators=2200,
                                     reg_alpha=0.4640, reg_lambda=0.8571,
                                     subsample=0.5213, silent=1,
                                     random_state =7, nthread = -1)
        model_lgb = lgb.LGBMRegressor(objective='regression', num_leaves=5,
                                      learning_rate=0.05, n_estimators=720,
                                      max_bin = 55, bagging_fraction = 0.8,
                                      bagging_freq = 5, feature_fraction = 0.2319,
                                      feature_fraction_seed=9, bagging_seed=9,
                                      min_data_in_leaf =6, min_sum_hessian_in_leaf = 11)
        models = {"lasso": lasso,
                  "ENet": ENet,
                  "KRR": KRR,
                  "GBoost": GBoost,
                  "xgb": model_xgb,
                  "lgb": model_lgb}
        averaged_models = AveragingModels(models=(ENet, GBoost, KRR, lasso))
        score = self.rmsle_cv(averaged_models)
        print(" Averaged base models score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))

        #for key, value in models.items():
        #    score = self.rmsle_cv(value)
        #    self.logger.info("\n{} score: {:.4f} ({:.4f})\n".format(key, score.mean(), score.std()))


class AveragingModels(BaseEstimator, RegressorMixin, TransformerMixin):
    def __init__(self, models):
        self.models = models
        
    # we define clones of the original models to fit the data in
    def fit(self, X, y):
        self.models_ = [clone(x) for x in self.models]
        
        # Train cloned base models
        for model in self.models_:
            model.fit(X, y)

        return self

    #Now we do the predictions for cloned models and average them
    def predict(self, X):
        predictions = np.column_stack([
            model.predict(X) for model in self.models_
        ])
        return np.mean(predictions, axis=1)   


def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    pass
    


if __name__ == "__main__":
    main()
