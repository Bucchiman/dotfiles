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
    特定のディレクトリからfzfを使ってファイルを選択し、
    その内容をLLDBのコマンドプロンプトに表示します。
    
    使用法: fzf_dir_select [directory_path]
    
    例: fzf_dir_select ~/scripts
    """
    # コマンドライン引数からディレクトリパスを取得
    args = command.split()
    
    # デフォルトディレクトリは現在のディレクトリ
    directory = os.getcwd()
    
    # 引数が提供されている場合は、そのディレクトリを使用
    if args and len(args) > 0:
        directory = os.path.expanduser(args[0])
    
    if not os.path.isdir(directory):
        result.AppendMessage(f"Error: '{directory}' is not a valid directory")
        return
    
    # fzfコマンドを実行して特定のディレクトリからファイルを選択
    try:
        fzf_process = subprocess.Popen(
            f'find "{directory}" -type f | fzf', 
            shell=True, 
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        output, error = fzf_process.communicate()
        
        if fzf_process.returncode == 0:
            selected_file = output.decode('utf-8').strip()
            if selected_file:
                # ファイルの内容を読み込む
                try:
                    with open(selected_file, 'r') as f:
                        file_content = f.read()
                    
                    result.AppendMessage(f"Selected file: {selected_file}")
                    result.AppendMessage("File content:")
                    result.AppendMessage("=" * 40)
                    result.AppendMessage(file_content)
                    result.AppendMessage("=" * 40)
                except Exception as e:
                    result.AppendMessage(f"Error reading file: {str(e)}")
            else:
                result.AppendMessage("No file selected")
        else:
            result.AppendMessage(f"Failed to run fzf: {error.decode('utf-8')}")
    except Exception as e:
        result.AppendMessage(f"Error: {str(e)}")
