#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	<+FILENAME+>
# Author: 8ucchiman
# CreatedDate:  <+DATE+>
# LastModified: 2023-01-23 14:14:11 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
import utils
# import numpy as np
# import pandas as pd


def main():
    args = utils.get_args()
    method = getattr(utils, args.method)
    <+CURSOR+>


if __name__ == "__main__":
    main()
