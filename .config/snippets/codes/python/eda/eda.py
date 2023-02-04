#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	eda
# Author: 8ucchiman
# CreatedDate:  2023-02-02 22:18:03 +0900
# LastModified: 2023-02-04 13:26:00 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import logging
from logging import getLogger, config
# import utils


class EDA(object):
    def __init__(self, train_df, test_df, target_column, logger, result_dir="results"):
        self.train_df = train_df
        self.test_df = test_df
        self.target_column = target_column
        self.features = [col for col in self.train_df.columns if col != self.target_column]
        self.result_dir = result_dir
        self.logger = logger

    def column_wise_missing(self):
        self.logger.info("-"*5+"train missing value"+"-"*5)
        self.logger.info("\n{}".format(self.train_df.isna().sum().sort_values(ascending=False)))
        self.logger.info("-"*5+"test missing value"+"-"*5)
        self.logger.info("\n{}".format(self.test_df.isna().sum().sort_values(ascending=False)))
        #train_null_df = pd.DataFrame(self.train_df.drop(["PassengerId"], axis=1).isna().sum())
        train_null_df = pd.DataFrame(self.train_df.isna().sum())
        train_null_df = train_null_df.sort_values(by=0, ascending=False)[:-1]
        test_null_df = pd.DataFrame(self.test_df.isna().sum())
        test_null_df = test_null_df.sort_values(by=0, ascending=False)
        self.logger.info("train_null_df:\n{}".format(train_null_df.index))

        fig = make_subplots(rows=1,
                            cols=2,
                            column_titles=["Train Data", "Test Data"],
                            x_title="Missing Values")
        fig.add_trace(go.Bar(x=train_null_df[0],
                             y=train_null_df.index,
                             orientation="h",
                             marker=dict(color=[n for n in range(12)],
                                         line_color='rgb(0,0,0)',
                                         line_width=2,
                                         coloraxis="coloraxis")),
                      1, 1)
        fig.add_trace(go.Bar(x=test_null_df[0],
                             y=test_null_df.index,
                             orientation="h",
                             marker=dict(color=[n for n in range(12)],
                                         line_color='rgb(0,0,0)',
                                         line_width=2,
                                         coloraxis="coloraxis")),
                      1, 2)
        fig.update_layout(showlegend=False, title_text="Column wise Null Value Distribution", title_x=0.5)
        fig.write_image(os.path.join(self.result_dir, "fig.png"))

    def distribution_of_continuous(self):
        df = pd.concat([self.train_df[self.features], self.test_df[self.features]], axis=0)
        self.text_features = ["Cabin", "Name"]
        self.cat_features = [col for col in self.features if df[col].nunique() < 25 and col not in self.text_features]
        self.cont_features = [col for col in self.features if df[col].nunique() >= 25 and col not in self.text_features]
        labels = ['Categorical', 'Continuous', 'Text']
        values = [len(self.cat_features), len(self.cont_features), len(self.text_features)]
        colors = ['#DE3163', '#58D68D']

        fig = go.Figure(data=[go.Pie(
            labels=labels,
            values=values, pull=[0.1, 0, 0],
            marker=dict(colors=colors,
                        line=dict(color='#000000', width=2)))])
        fig.write_image(os.path.join(self.result_dir, "features_cat_cont_text_Pie.png"))
        train_age = self.train_df.copy()
        test_age = self.test_df.copy()
        train_age["type"] = "Train"
        test_age["type"] = "Test"
        ageDf = pd.concat([train_age, test_age])
        fig = px.histogram(data_frame=ageDf,
                           x="Age",
                           color="type",
                           color_discrete_sequence=['#58D68D', '#DE3163'],
                           marginal="box",
                           nbins=100,
                           template="plotly_white")
        fig.update_layout(title="Distribution of Age", title_x=0.5)
        fig.write_image(os.path.join(self.result_dir, "age_histogram.png"))

    def distribution_of_category(self):
        if len(self.cat_features) == 0:
            self.logger.info("No categories")
        else:
            ncols = 2
            nrows = 2
            fig, axes = plt.subplots(nrows, ncols, figsize=(18, 10))
            for r in range(nrows):
                for c in range(ncols):
                    col = self.cat_features[r*ncols+c]
                    sns.countplot(self.train_df[col],
                                  ax=axes[r, c],
                                  palette="viridis",
                                  label='Train data')
                    sns.countplot(self.test_df[col],
                                  ax=axes[r, c],
                                  palette="magma",
                                  label='Test data')
                    axes[r, c].legend()
                    axes[r, c].set_ylabel('')
                    axes[r, c].set_xlabel(col, fontsize=20)
                    axes[r, c].tick_params(labelsize=10, width=0.5)
                    axes[r, c].xaxis.offsetText.set_fontsize(4)
                    axes[r, c].yaxis.offsetText.set_fontsize(4)
            #plt.show()

    def correlation_matrix(self):
        fig = px.imshow(self.train_df.corr(),
                        text_auto=True,
                        aspect="auto",
                        color_continuous_scale="viridis")
        fig.write_image(os.path.join(self.result_dir, "hoge.png"))
        #fig.show()

    def get_logger(self, log_dir, file_name):
        os.makedirs(log_dir, exist_ok=True)
        log_path = os.path.join(log_dir, file_name)

        logging.basicConfig(level=logging.INFO)
        self.logger = logging.getLogger()
        self.logger.setLevel(logging.INFO)
        formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        file_handler = logging.FileHandler(log_path)
        file_handler.setLevel(logging.INFO)
        file_handler.setFormatter(formatter)
        self.logger.addHandler(file_handler)
        self.logger.info("Log file is %s." % log_path)


if __name__ == "__main__":
    eda = EDA(pd.read_csv("./datas/train.csv"), pd.read_csv("./datas/test.csv"), "Transported")
    eda.get_logger(".", "sample.log")
    eda.column_wise_missing()
    eda.distribution_of_continuous()
    # eda.distribution_of_category()
    eda.correlation_matrix()
