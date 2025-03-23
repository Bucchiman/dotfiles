#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName:     local
# Author:       8ucchiman
# CreatedDate:  2025-03-23 15:03:56
# LastModified: 2023-02-18 14:28:37 +0900
# Reference:    8ucchiman.jp
# Description:  ---
#


import os
import subprocess

def fzf_select_file(debugger, command, result, internal_dict):
    """
    fzfを使ってファイルを選択し、LLDBで開きます。
    使用法: fzf_select
    """
    # 現在のディレクトリからfzfを実行
    fzf_process = subprocess.Popen('find . -type f | fzf', 
                                  shell=True, 
                                  stdout=subprocess.PIPE,
                                  stderr=subprocess.PIPE)
    output, error = fzf_process.communicate()
    
    if fzf_process.returncode == 0:
        selected_file = output.decode('utf-8').strip()
        if selected_file:
            debugger.HandleCommand(f'command source -s "{selected_file}"')
            result.AppendMessage(f"Loaded file: {selected_file}")
        else:
            result.AppendMessage("No file selected")
    else:
        result.AppendMessage("Failed to run fzf")
