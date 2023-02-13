#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	eda
# Author: 8ucchiman
# CreatedDate:  2023-02-02 22:18:03 +0900
# LastModified: 2023-02-13 20:45:02 +0900
# Reference: 8ucchiman.jp
#


import os
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import plotly.express as px
import plotly.graph_objects as go
from plotly.subplots import make_subplots
import logging
from utils import get_args
# from logging import getLogger, config


class EDA(object):
    def __init__(self,
                 train_csv: str,
                 test_csv: str,
                 target: str,
                 logger: logging.RootLogger,
                 imshow=False,
                 results_dir="results",):
        self.train_df = pd.read_csv(train_csv)
        self.test_df = pd.read_csv(test_csv)
        self.target = target
        # self.train_df.drop(["PassengerId"], axis=1, inplace=True)
        self.features = [col for col in self.train_df.columns if col != self.target]
        self.results_dir = results_dir
        self.logger = logger
        self.logger.info(self.features)
        self.imshow = imshow
        #self.total_df = pd.concat([self.train_df[self.features], self.test_df[self.features]], axis=0)
        self.logger.info("features info:\n{}".format(self.train_df.info()))
        #self.text_features = ["Cabin", "Name"]
        #self.cat_features = [col for col in self.features if self.total_df[col].nunique() < 25 and col not in self.text_features]
        #self.cont_features = [col for col in self.features if df[col].nunique() >= 25 and col not in self.text_features]
        self.logger.info("describe/numerical\n{}".format(self.train_df.describe()))
        self.logger.info("describe/categorical\n{}".format(self.train_df.describe(include='O')))

    def column_wise_missing(self):
        self.logger.info("-"*5+"train missing value"+"-"*5)
        self.logger.info("\n{}".format(self.train_df.isna().sum().sort_values(ascending=False)))
        self.logger.info("-"*5+"test missing value"+"-"*5)
        self.logger.info("\n{}".format(self.test_df.isna().sum().sort_values(ascending=False)))
        missing_train_column = pd.DataFrame(self.train_df.isna().sum()).sort_values(by=0, ascending=False)[:-1]
        missing_test_column = pd.DataFrame(self.test_df.isna().sum()).sort_values(by=0, ascending=False)

        fig = make_subplots(rows=1,
                            cols=2,
                            column_titles=["Train Data", "Test Data"],
                            x_title="Missing Values")
        fig.add_trace(go.Bar(x=missing_train_column[0],
                             y=missing_train_column.index,
                             orientation="h",
                             marker=dict(color=[n for n in range(12)],
                                         line_color='rgb(0,0,0)',
                                         line_width=2,
                                         coloraxis="coloraxis")),
                      1, 1)
        fig.add_trace(go.Bar(x=missing_test_column[0],
                             y=missing_test_column.index,
                             orientation="h",
                             marker=dict(color=[n for n in range(12)],
                                         line_color='rgb(0,0,0)',
                                         line_width=2,
                                         coloraxis="coloraxis")),
                      1, 2)
        fig.update_layout(showlegend=False, title_text="Column wise Null Value Distribution", title_x=0.5)
        if self.imshow:
            fig.show()
        fig.write_image(os.path.join(self.results_dir, "column_wise_distribution.png"))

    def row_wise_missing(self):
        missing_train_row = self.train_df.isna().sum(axis=1)
        missing_train_row = pd.DataFrame(missing_train_row.value_counts()/missing_train_row.shape[0]).reset_index()
        missing_test_row = self.test_df.isna().sum(axis=1)
        missing_test_row = pd.DataFrame(missing_test_row.value_counts()/missing_test_row.shape[0]).reset_index()
        missing_train_row.columns = ['no', 'count']
        missing_test_row.columns = ['no', 'count']
        missing_train_row["count"] = missing_train_row["count"]*100
        missing_test_row["count"] = missing_test_row["count"]*100
        fig = make_subplots(rows=1, cols=2, column_titles=["Train Data", "Test Data"], x_title="Missing Values",)
        fig.add_trace(go.Bar(x=missing_train_row["no"],
                             y=missing_train_row["count"],
                             marker=dict(color=[n for n in range(4)],
                             line_color='rgb(0,0,0)',
                             line_width=3,
                             coloraxis="coloraxis")),
                      1, 1)
        fig.add_trace(go.Bar(x=missing_test_row["no"],
                             y=missing_test_row["count"],
                             marker=dict(color=[n for n in range(4)],
                             line_color='rgb(0,0,0)',
                             line_width=3,
                             coloraxis="coloraxis")),
                      1, 2)
        fig.update_layout(showlegend=False, title_text="Row wise Null Value Distribution", title_x=0.5)
        if self.imshow:
            fig.show()
        fig.write_image(os.path.join(self.results_dir, "row_wise_distribution.png"))

    def single_histogram(self, feature: str):
        fig = sns.displot(self.train_df[feature])
        fig.savefig(os.path.join(self.results_dir, "single_{}_histoplot.png".format(feature)))

    def multi_histogram(self, features: list[str]):
        self.train_df[features].hist(bins=100)
        plt.savefig(os.path.join(self.results_dir, "multi_histoplot.png"))

    def scatter_target_feature(self, feature: str):
        data = pd.concat([self.train_df[self.target], self.train_df[feature]], axis=1)
        fig = data.plot.scatter(x=feature, y=self.target)
        fig.figure.savefig("scatter_{}_{}.png".format(feature, self.target))

    def boxplot_target_category_feature(self, category_feature):
        data = pd.concat([self.train_df[self.target], self.train_df[category_feature]], axis=1)
        f, ax = plt.subplots(figsize=[8, 6])
        fig = sns.boxplot(x=category_feature, y=self.target, data=data)
        fig.savefig("boxplot_{}_{}.png".format(self.target, category_feature))

    def distribution_of_continuous(self):
        labels = ['Categorical', 'Continuous', 'Text']
        values = [len(self.cat_features), len(self.cont_features), len(self.text_features)]
        colors = ['#DE3163', '#58D68D']

        fig = go.Figure(data=[go.Pie(labels=labels,
                                     values=values, pull=[0.1, 0, 0],
                                     marker=dict(colors=colors,
                                                 line=dict(color='#000000', width=2)))])
        fig.write_image(os.path.join(self.results_dir, "features_cat_cont_text_Pie.png"))
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
        fig.write_image(os.path.join(self.results_dir, "age_histogram.png"))

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
                    sns.countplot(x=col,
                                  data=self.train_df,
                                  ax=axes[r, c],
                                  palette="viridis",
                                  label='Train data')
                    sns.countplot(x=col,
                                  data=self.test_df,
                                  ax=axes[r, c],
                                  palette="magma",
                                  label='Test data')
                    axes[r, c].legend()
                    axes[r, c].set_ylabel('')
                    axes[r, c].set_xlabel(col, fontsize=20)
                    axes[r, c].tick_params(labelsize=10, width=0.5)
                    axes[r, c].xaxis.offsetText.set_fontsize(4)
                    axes[r, c].yaxis.offsetText.set_fontsize(4)
            if self.imshow:
                fig.show()
            fig.savefig(os.path.join(self.results_dir, "category_distribution.png"))

    def correlation_matrix(self):
        fig = px.imshow(self.train_df.corr(),
                        text_auto=True,
                        aspect="auto",
                        color_continuous_scale="viridis")
        if self.imshow:
            fig.show()

        fig = sns.heatmap(self.train_df.corr())
        # fig.figure.savefig(os.path.join(self.results_dir, "correlation_matrix.png"))

    def scatterplot(self, features: list[str]):
        sns.set()
        fig = sns.pairplot(self.train_df[features], size=2.5)
        fig.figure.savefig(os.path.join(self.results_dir, "scatterplot.png"))

    def groupby_pivoting(self, feature, target=None):
        if not target:
            target = self.target
        self.logger.info("{}/{} groupby\n{}".format(feature, target, self.train_df[[feature, target]].groupby([feature], as_index=False).mean().sort_values(target)))

    def facetgrid(self, feature, target=None, **kwargs):
        if not target:
            target = self.target
        grid = sns.FacetGrid(self.train_df, row=feature, col=target)
        grid.map(getattr(sns, kwargs.method))
        pass

    @classmethod
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


def main():
    args = get_args()
    train_path = os.path.join(args.data_dir, args.train_csv)
    test_path = os.path.join(args.data_dir, args.test_csv)
    logger = EDA.get_logger(log_dir=args.log_dir, file_name=args.log_file)
    eda = EDA(train_path, test_path, "formation_energy_per_atom", logger, imshow=False, results_dir=args.results_dir)
    # eda.get_logger(".", "sample.log")
    eda.single_histogram('formation_energy_per_atom')
    # eda.scatter_target_feature('GrLivArea')
    # eda.scatterplot(['SalePrice', 'OverallQual', 'GrLivArea', 'GarageCars', 'TotalBsmtSF', 'FullBath', 'YearBuilt'])
    # eda.column_wise_missing()
    # eda.row_wise_missing()
    # eda.distribution_of_continuous()
    # eda.distribution_of_category()
    # eda.correlation_matrix()
    pass


if __name__ == "__main__":
    main()
