#!/usr/bin/env lua
--
-- FileName:     init
-- Author: 8ucchiman
-- CreatedDate:  2023-03-26 11:40:26 +0900
-- LastModified: 2023-03-26 13:59:00 +0900
-- Reference: 8ucchiman.jp
--


--vim.api.nvim_command('set runtimepath^=/home/bucchiman/.config/snippets/codes/lua/nvim')
local home_dir = os.getenv('HOME')
local cfg_dir = home_dir..'/.config/snippets/codes/lua/nvim'
--print(cfg_dir)
vim.api.nvim_command('set runtimepath^='..cfg_dir)

--require("")
