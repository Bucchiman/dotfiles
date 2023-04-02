#!/usr/bin/env lua
--
-- FileName:     lua/base
-- Author: 8ucchiman
-- CreatedDate:  2023-04-02 14:51:17 +0900
-- LastModified: 2023-04-02 14:51:53 +0900
-- Reference: 8ucchiman.jp
--


vim.cmd("autocmd!")

vim.api.nvim_create_autocmd(
    "InsertLeave",
    {
        pattern = "*",
        command = "set nopaste"
    }
)

vim.opt.formatopptions:append { 'r' }
