#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	eda
# Author: 8ucchiman
# CreatedDate:  2023-02-02 22:18:03 +0900
# LastModified: 2023-02-02 23:34:44 +0900
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
    def __init__(self, train_df, test_df, target_column):
        self.train_df = train_df
        self.test_df = test_df
        self.target_column = target_column
        self.features_columns = [col for col in self.train_df.columns if col != self.target_column]


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
        fig.write_image("fig.png")




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
