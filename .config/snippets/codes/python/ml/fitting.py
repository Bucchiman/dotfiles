#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	learn
# Author: 8ucchiman
# CreatedDate:  2023-02-04 11:35:39 +0900
# LastModified: 2023-02-15 17:13:03 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import argparse
import numpy as np
# from lazypredict.Supervised import LazyRegressor
from sklearn.linear_model import ElasticNet, Lasso, BayesianRidge, LassoLarsIC
from sklearn.ensemble import RandomForestRegressor, GradientBoostingRegressor
from sklearn.kernel_ridge import KernelRidge
from sklearn.preprocessing import RobustScaler
from sklearn.base import BaseEstimator, TransformerMixin, RegressorMixin, clone
from sklearn.pipeline import make_pipeline
from sklearn.model_selection import KFold, cross_val_score
from sklearn.metrics import mean_squared_error, accuracy_score
import xgboost as xgb
import logging
import pandas as pd
# import utils


class Fitting(object):
    def __init__(self,
                 train_df: pd.DataFrame,
                 test_df: pd.DataFrame,
                 target: str,
                 index: str,
                 logger: logging.RootLogger,
                 problem_type: str,
                 index_df: pd.DataFrame = None, seed=43):
        self.train_df = train_df
        self.test_df = test_df
        if index_df is None:
            self.test_index = self.test_df[index]
            self.train_df.drop([index], axis=1, inplace=True)
            self.test_df.drop([index], axis=1, inplace=True)
        else:
            self.test_index = index_df
        self.target = target
        # self.test_id = self.test_df["id"]
        self.X = self.train_df.drop([self.target], axis=1).values
        self.y = self.train_df[self.target].values
        self.X_test = self.test_df.values
        self.problem_type = problem_type
        self.seed = seed
        if logger is None:
            self.logger = self.get_logger(".", "LOG.log")
        else:
            self.logger = logger

    def cross_validation(self, X_train, X_valid, y_train, y_valid):
        self.X_train = X_train
        self.X_valid = X_valid
        self.y_train = y_train
        self.y_valid = y_valid

    def run(self):
        pass

    def run_lazypredict(self):
        from lazypredict.Supervised import LazyRegressor
        clf = LazyRegressor(verbose=0,
                            ignore_warnings=True,
                            custom_metric=None,
                            random_state=self.seed,)

        models, predictions = clf.fit(self.X_train, self.X_test, self.y_train, self.y_test)

    def kfold_cross_validation(self):
        self.kf = KFold(n_splits=5, shuffle=True, random_state=self.seed)
        self.nkf = KFold(n_splits=5, shuffle=True, random_state=self.seed).get_n_splits(self.train_df.values)
        self.logger.info("{}".format(self.kf))

    def rmsle_cv(self, model):
        rmse = np.sqrt(-cross_val_score(model, self.X, self.y, scoring="neg_mean_squared_error", cv=self.nkf))
        return rmse

    # def try_rmse(self, model):
    #     return cross_val_score(model, self.X, self.y, scoring="rmse", cv=self.nkf)

    def base_models(self):
        import lightgbm as lgb
        # self.lasso = make_pipeline(RobustScaler(), Lasso(alpha=0.0005, random_state=1))
        # self.ENet = make_pipeline(RobustScaler(), ElasticNet(alpha=0.0005, l1_ratio=.9, random_state=3))
        # self.KRR = KernelRidge(alpha=0.6, kernel='polynomial', degree=2, coef0=2.5)
        # self.GBoost = GradientBoostingRegressor(n_estimators=3000,
        #                                         learning_rate=0.05,
        #                                         max_depth=4,
        #                                         max_features='sqrt',
        #                                         min_samples_leaf=15,
        #                                         min_samples_split=10,
        #                                         loss='huber',
        #                                         random_state=5)
        # self.model_xgb = xgb.XGBRegressor(colsample_bytree=0.4603,
        #                                   gamma=0.0468,
        #                                   learning_rate=0.05,
        #                                   max_depth=3,
        #                                   min_child_weight=1.7817,
        #                                   n_estimators=2200,
        #                                   reg_alpha=0.4640,
        #                                   reg_lambda=0.8571,
        #                                   subsample=0.5213,
        #                                   silent=1,
        #                                   random_state=7,
        #                                   nthread=-1)
        #self.model_lgb = lgb.LGBMRegressor(objective='regression',
        #                                   num_leaves=5,
        #                                   learning_rate=0.05,
        #                                   n_estimators=720,
        #                                   max_bin=55,
        #                                   bagging_fraction=0.8,
        #                                   bagging_freq=5,
        #                                   feature_fraction=0.2319,
        #                                   feature_fraction_seed=9,
        #                                   bagging_seed=9,
        #                                   min_data_in_leaf=6,
        #                                   min_sum_hessian_in_leaf=11)
        if self.problem_type == "Regression":
            lgbm_params = {
                "objective": "regression",
                "learning_rate": 0.2,
                "reg_alpha": 0.1,
                "reg_lambda": 0.1,
                "max_depth": 5,
                "n_estimators": 1000000, 
                "colsample_bytree": 0.9,
            }
            self.model_lgb = lgb.LGBMRegressor(**lgbm_params)
        else:
            lgbm_params = {
                "max_depth": 5
            }
            self.model_lgb = lgb.LGBMClassifier(**lgbm_params)

        # score = self.rmsle_cv(self.lasso)
        # print("\nLasso score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        # score = self.rmsle_cv(self.ENet)
        # print("ElasticNet score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        # #score = self.rmsle_cv(self.KRR)
        # #print("Kernel Ridge score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        # score = self.rmsle_cv(self.GBoost)
        # print("Gradient Boosting score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        # score = self.rmsle_cv(self.model_xgb)
        # print("Xgboost score: {:.4f} ({:.4f})\n".format(score.mean(), score.std()))
        # score = self.rmsle_cv(self.model_lgb)
        # print("LGBM score: {:.4f} ({:.4f})\n" .format(score.mean(), score.std()))

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
        self.model_lgb.fit(self.X_train, self.y_train, eval_set=[(self.X_valid, self.y_valid)], early_stopping_rounds=20, eval_metric="rmse", verbose=200)
        lgb_train_pred = self.model_lgb.predict(self.X)
        # self.lgb_pred = np.expm1(self.model_lgb.predict(self.X_test))
        self.lgb_pred = self.model_lgb.predict(self.X_test)
        print(self.rmsle(self.y, lgb_train_pred))

    def ensembling(self):
        self.ensemble = self.stacked_pred*0.70 + self.xgb_pred*0.15 + self.lgb_pred*0.15

    def submission(self):
        sub = pd.DataFrame()

        sub[self.target] = self.lgb_pred
        sub = pd.concat([self.test_index, sub[self.target]], axis=1)
        sub.to_csv("submission.csv", index=False)

    def get_logger(self, log_dir, file_name):
        os.makedirs(log_dir, exist_ok=True)
        log_path = os.path.join(log_dir, file_name)

        logging.basicConfig(level=logging.INFO)
        logger = logging.getLogger()
        logger.setLevel(logging.INFO)
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        file_handler = logging.FileHandler(log_path)
        file_handler.setLevel(logging.INFO)
        file_handler.setFormatter(formatter)
        logger.addHandler(file_handler)
        logger.info("Log file is %s." % log_path)
        return logger



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


class SklearnHelper(object):
    def __init__(self, clf, seed=0, params=None):
        params['random_state'] = seed
        self.clf = clf(**params)

    def train(self, x_train, y_train):
        self.clf.fit(x_train, y_train)

    def predict(self, x):
        return self.clf.predict(x)

    def fit(self, x, y):
        return self.clf.fit(x, y)

    def feature_importances(self, x, y):
        print(self.clf.fit(x, y).feature_importances_)


def get_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--results_dir', type=str, default="../results", help="results dir specify")
    parser.add_argument('--data_dir', type=str, default="./datas", help="data directory specify")
    parser.add_argument('--train_csv', type=str, default="train.csv", help="train.csv specify")
    parser.add_argument('--test_csv', type=str, default="test.csv", help="test.csv specify")
    parser.add_argument('--target_col', type=str, required=True, help="target to predict")
    parser.add_argument('--index_col', type=str, required=True, help="sample id")
    parser.add_argument('--problem_type', type=str, required=True, choices=['Regression', 'Classification'], help="problem type[Regression, Classification]")
    # parser.add_argument('--method_name', type="str", default="make_date_log_directory", help="method name here in utils.py")

    args = parser.parse_args()
    return args


def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    args = get_args()
    train_path = os.path.join(args.data_dir, args.train_csv)
    test_path = os.path.join(args.data_dir, args.test_csv)
    train_df = pd.read_csv(train_path)
    test_df = pd.read_csv(test_path)
    fitting = Fitting(train_df, test_df, args.target_col, args.index_col, logger=None, problem_type=args.problem_type)
    fitting.kfold_cross_validation()


if __name__ == "__main__":
    main()
