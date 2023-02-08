#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	learn
# Author: 8ucchiman
# CreatedDate:  2023-02-04 11:35:39 +0900
# LastModified: 2023-02-08 22:19:06 +0900
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
import pandas as pd
# import utils


class Fitting(object):
    def __init__(self, train_df, test_df, target, logger):
        self.train_df = train_df
        self.test_df = test_df
        self.target = target
        self.logger = logger
        self.X = self.train_df.drop([self.target], axis=1).values
        self.y = self.train_df[self.target].values
        self.X_test = self.test_df.values

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
        self.lasso = make_pipeline(RobustScaler(), Lasso(alpha=0.0005, random_state=1))
        self.ENet = make_pipeline(RobustScaler(), ElasticNet(alpha=0.0005, l1_ratio=.9, random_state=3))
        self.KRR = KernelRidge(alpha=0.6, kernel='polynomial', degree=2, coef0=2.5)
        self.GBoost = GradientBoostingRegressor(n_estimators=3000,
                                                learning_rate=0.05,
                                                max_depth=4,
                                                max_features='sqrt',
                                                min_samples_leaf=15,
                                                min_samples_split=10,
                                                loss='huber',
                                                random_state=5)
        self.model_xgb = xgb.XGBRegressor(colsample_bytree=0.4603,
                                          gamma=0.0468,
                                          learning_rate=0.05,
                                          max_depth=3,
                                          min_child_weight=1.7817,
                                          n_estimators=2200,
                                          reg_alpha=0.4640,
                                          reg_lambda=0.8571,
                                          subsample=0.5213,
                                          silent=1,
                                          random_state=7,
                                          nthread=-1)
        self.model_lgb = lgb.LGBMRegressor(objective='regression',
                                           num_leaves=5,
                                           learning_rate=0.05,
                                           n_estimators=720,
                                           max_bin=55,
                                           bagging_fraction=0.8,
                                           bagging_freq=5,
                                           feature_fraction=0.2319,
                                           feature_fraction_seed=9,
                                           bagging_seed=9,
                                           min_data_in_leaf=6,
                                           min_sum_hessian_in_leaf=11)
        score = self.rmsle_cv(self.lasso)
        print("\nLasso score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        score = self.rmsle_cv(self.ENet)
        print("ElasticNet score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        #score = self.rmsle_cv(self.KRR)
        #print("Kernel Ridge score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        score = self.rmsle_cv(self.GBoost)
        print("Gradient Boosting score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        score = self.rmsle_cv(self.model_xgb)
        print("Xgboost score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        score = self.rmsle_cv(self.model_lgb)
        print("LGBM score: {:.4f} ({:.4f})\n" .format(score.mean(), score.std()))

    def average_model(self):
        averaged_models = AveragingModels(models=(self.ENet,
                                                  self.GBoost,
                                                  self.lasso))
        score = self.rmsle_cv(averaged_models)
        print("Averaged base models score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))

        #for key, value in models.items():
        #    score = self.rmsle_cv(value)
        #    self.logger.info("\n{} score: {:.4f} ({:.4f})\n".format(key, score.mean(), score.std()))

    def stacking_model(self):
        self.stacked_averaged_models = StackingAveragedModels(base_models=(self.ENet, self.GBoost), meta_model = self.lasso)

        score = self.rmsle_cv(self.stacked_averaged_models)
        print("Stacking Averaged models score: {:.4f} ({:.4f})".format(score.mean(), score.std()))

    def rmsle(self, y, y_pred):
        return np.sqrt(mean_squared_error(y, y_pred))

    def stackedregressor(self):
        self.stacked_averaged_models.fit(self.X, self.y)
        stacked_train_pred = self.stacked_averaged_models.predict(self.X)
        self.stacked_pred = np.expm1(self.stacked_averaged_models.predict(self.X_test))
        print(self.rmsle(self.y, stacked_train_pred))

    def xgboost(self):
        self.model_xgb.fit(self.X, self.y)
        xgb_train_pred = self.model_xgb.predict(self.X)
        self.xgb_pred = np.expm1(self.model_xgb.predict(self.X_test))
        print(self.rmsle(self.y, xgb_train_pred))

    def lightgbm(self):
        self.model_lgb.fit(self.X, self.y)
        lgb_train_pred = self.model_lgb.predict(self.X)
        self.lgb_pred = np.expm1(self.model_lgb.predict(self.X_test))
        print(self.rmsle(self.y, lgb_train_pred))


    def ensembling(self):
        self.ensemble = self.stacked_pred*0.70 + self.xgb_pred*0.15 + self.lgb_pred*0.15

    def submission(self):
        sub = pd.DataFrame()
        # sub['id'] = self.test_id
        sub[self.target] = self.ensemble
        sub.to_csv("submission.csv", index=False)


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


class StackingAveragedModels(BaseEstimator, RegressorMixin, TransformerMixin):
    def __init__(self, base_models, meta_model, n_folds=5):
        self.base_models = base_models
        self.meta_model = meta_model
        self.n_folds = n_folds

    # We again fit the data on clones of the original models
    def fit(self, X, y):
        self.base_models_ = [list() for x in self.base_models]
        self.meta_model_ = clone(self.meta_model)
        kfold = KFold(n_splits=self.n_folds, shuffle=True, random_state=156)

        # Train cloned base models then create out-of-fold predictions
        # that are needed to train the cloned meta-model
        out_of_fold_predictions = np.zeros((X.shape[0], len(self.base_models)))
        for i, model in enumerate(self.base_models):
            for train_index, holdout_index in kfold.split(X, y):
                instance = clone(model)
                self.base_models_[i].append(instance)
                instance.fit(X[train_index], y[train_index])
                y_pred = instance.predict(X[holdout_index])
                out_of_fold_predictions[holdout_index, i] = y_pred

        # Now train the cloned  meta-model using the out-of-fold predictions as new feature
        self.meta_model_.fit(out_of_fold_predictions, y)
        return self

    # Do the predictions of all base models on the test data and use the averaged predictions as
    # meta-features for the final prediction which is done by the meta-model
    def predict(self, X):
        meta_features = np.column_stack([
            np.column_stack([model.predict(X) for model in base_models]).mean(axis=1)
            for base_models in self.base_models_])
        return self.meta_model_.predict(meta_features)


def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    pass


if __name__ == "__main__":
    main()
