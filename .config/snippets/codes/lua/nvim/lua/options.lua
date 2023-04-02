#!/usr/bin/env lua
--
-- FileName:     options
-- Author: 8ucchiman
-- CreatedDate:  2023-03-31 23:36:03 +0900
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference: 8ucchiman.jp
--


--
-- shell:        ![Command]でシェル実行できる


local options = {
    number = true,
    backup = false,
    virtualedit = "onemore",
    hidden = true,
    autoindent = true,
    wrapscan = true,
    encoding = "utf-8",
    fileencoding = "utf-8",
    title = true,
    backup = false,
    clipboard = "unnamedplus",
    cmdheight = 2,
    completeopt = { "menuone", "noselect" },
    conceallevel = 0,
    hlsearch = true,
    ignorecase = true,
    mouse = "a",
    pumheight = 10,
    showmode = false,
    showtabline = 2,
    smartcase = false,
    smartindent = true,
    swapfile = false,
    termguicolors = true,
    timeoutlen = 300,
    undofile = true,
    updatetime = 300,
    writebackup = false,
    shell = "zsh",
    expandtab = true,
    shiftwidth = 4,
    tabstop = 8,
    cursorline = true,
    relativenumber = false,
    numberwidth = 4,
    signcolumn = "yes",
    wrap = false,
    winblend = 0,
    wildoptions = "pum",
    pumblend = 5,
    background = "dark",
    scrolloff = 8,
    sidescrolloff = 8,
    guifont = "monospace:h17",
    splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
    splitright = false, -- オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
    inccommand = "split"
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end

--vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work


local opts = { noremap = true, silent = true }
local term_opts = { silent = ture }
