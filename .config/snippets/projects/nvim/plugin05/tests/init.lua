#!/usr/bin/env lua
--
-- FileName:     init
-- Author:       8ucchiman
-- Email:        8ucchiman@gmail.com
-- CreatedDate:  2023-05-01 10:38:03
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference:    8ucchiman.jp
-- Description:  ---
--


local plenary_dir = os.getenv("PLENARY_DIR") or "/tmp/plenary.nvim"
local is_not_a_directory = vim.fn.isdirectory(plenary_dir) == 0
if is_not_a_directory then
    vim.fn.system({"git", "clone", "https://github.com/nvim-lua/plenary.nvim"})
end

-- local current_dir = os.getnev("PWD")
vim.opt.rtp:append(".")
vim.opt.rtp:append(plenary_dir)

-- print(vim.inspect(vim.api.nvim_list_runtime_paths()))
-- print(vim.fs.normalize('.'))
-- print(os.getenv("PWD"))

vim.cmd("runtime plugin/plenary.vim")
require("plenary.busted")
