#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName:     lldb_shell
# Author:       8ucchiman
# CreatedDate:  2025-03-24 14:02:10
# LastModified: 2023-02-18 14:28:37 +0900
# Reference:    8ucchiman.jp
# Description:  ---
#

import lldb

def handle_command(debugger, command, exe_ctx, result, internal_dict):
    # `platform shell` を使ってコマンドを実行
    interpreter = debugger.GetCommandInterpreter()
    res = lldb.SBCommandReturnObject()
    interpreter.HandleCommand(f"platform shell {command}", res)

    # 実行結果を表示
    if res.Succeeded():
        print(res.GetOutput())
    else:
        print(res.GetError())

def __lldb_init_module(debugger, internal_dict):
    # 不明なコマンドをすべて `handle_command` に渡すようにする
    debugger.HandleCommand('command script add -f {}.handle_command !'.format(__name__))
