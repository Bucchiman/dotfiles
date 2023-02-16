#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	embedding
# Author: 8ucchiman
# CreatedDate:  2023-02-16 12:06:33 +0900
# LastModified: 2023-02-16 12:07:34 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
from torch import nn
# import utils
# from import utils import get_args, get_logger
# import numpy as np
# import pandas as pd


def main():
    # args = utils.get_args()
    # method = getattr(utils, args.method)
    embedding = nn.Embedding(10, 3)
    print(embedding.weight)


if __name__ == "__main__":
    main()
