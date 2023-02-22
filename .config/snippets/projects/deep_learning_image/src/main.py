#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName: 	main
# Author: 8ucchiman
# CreatedDate:  2023-02-17 11:59:33 +0900
# LastModified: 2023-02-17 15:21:27 +0900
# Reference: 8ucchiman.jp
#


import os
import sys
# import utils
from utils import get_dl_args, get_logger
from transform import Transform
from datasets import ImageDataset
from models import TimmModel
from train import Train
from torch.utils.data import DataLoader
# import numpy as np
import pandas as pd


def main():
    args = get_dl_args()
    logger = get_logger(args.log_file, args.log_dir)
    # method = getattr(utils, args.method)
    train_img_path = os.path.join(args.data_dir, args.train_img_dir)
    test_img_path = os.path.join(args.data_dir, args.test_img_dir)
    label_path = os.path.join(args.data_dir, args.train_label_file)
    transform = Transform().get_transform()
    dataset = ImageDataset(train_img_path, label_path, transform=transform)
    dataloader = DataLoader(dataset, batch_size=20, shuffle=True)

    model = TimmModel(args.model_name, num_classes=8)

    train = Train(dataloader, model())
    train.running()


if __name__ == "__main__":
    main()
