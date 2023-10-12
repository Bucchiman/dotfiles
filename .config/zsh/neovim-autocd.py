#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
# FileName:     neovim-autocd
# Author:       8ucchiman
# CreatedDate:  2023-10-12 16:35:59
# LastModified: 2023-02-18 14:28:37 +0900
# Reference:    https://github.com/neovim/neovim/issues/3294
# Description:  ---
#


import neovim
import os

nvim = neovim.attach('socket', path=os.environ['NVIM_LISTEN_ADDRESS'])
nvim.vars['__autocd_cwd'] = os.getcwd()
nvim.command('execute "lcd" fnameescape(g:__autocd_cwd)')
del nvim.vars['__autocd_cwd']
