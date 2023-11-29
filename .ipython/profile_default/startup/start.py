#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName:     start
# Author:       8ucchiman
# CreatedDate:  2023-11-29 11:48:50
# LastModified: 2023-02-18 14:28:37 +0900
# Reference:    8ucchiman.jp
# Description:  ---
#




import pandas as pd
import numpy as np

# Pandas options
pd.options.display.max_columns = 30
pd.options.display.max_rows = 20

from IPython import get_ipython
ipython = get_ipython()

# If in ipython, load autoreload extension
if 'ipython' in globals():
    print('\nWelcome to IPython!')
    ipython.magic('load_ext autoreload')
    ipython.magic('autoreload 2')

# Display all cell outputs in notebook
from IPython.core.interactiveshell import InteractiveShell
InteractiveShell.ast_node_interactivity = 'all'

# Visualization
# import plotly.plotly as py
# import plotly.graph_objs as go
# from plotly.offline import iplot, init_notebook_mode
# init_notebook_mode(connected=True)
# import cufflinks as cf
# cf.go_offline(connected=True)
# cf.set_config_file(theme='pearl')
# 
# print('Your favorite libraries have been loaded.')
import matplotlib.pyplot as plt
