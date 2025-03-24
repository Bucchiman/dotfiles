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

def fzf_select_file_from_dir(debugger, command, result, internal_dict):
    """
    fzfを使ってファイルを選択し、その内容をLLDBで表示します。
    使用法: fzf_select
    """
    # fzfでファイル選択
    fzf_process = subprocess.Popen('cd ~/dotfiles/.config/lldb/docs; find . -type f | fzf --height 100% --preview \'cat {}\'', 
                                   shell=True, 
                                   stdout=subprocess.PIPE,
                                   stderr=subprocess.PIPE)
    output, error = fzf_process.communicate()
    
    if fzf_process.returncode == 0:
        selected_file = output.decode('utf-8').strip()
        if selected_file:
            file_path = os.path.expanduser(f"~/dotfiles/.config/lldb/docs/{selected_file}")
            try:
                with open(file_path, 'r', encoding='utf-8') as file:
                    content = file.read()
                result.AppendMessage(f"Loaded file: {selected_file}\n{content}")
            except Exception as e:
                result.AppendMessage(f"Error reading file: {e}")
        else:
            result.AppendMessage(f"Failed to run fzf: {error.decode('utf-8')}")
    except Exception as e:
        result.AppendMessage(f"Error: {str(e)}")
