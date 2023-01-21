#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	<+FILENAME+>
# CreatedDate:  <+DATE+>
# LastModified: 2023-01-21 16:50:59 +0900
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
