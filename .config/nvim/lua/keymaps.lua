#!/usr/bin/env lua
--
-- FileName:     lua/keymaps
-- Author: 8ucchiman
-- CreatedDate:  2023-03-31 23:40:18 +0900
-- LastModified: 2023-01-23 14:18:33 +0900
-- Reference: https://zenn.dev/hisasann/articles/neovim-settings-to-lua
--


local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap



-- Nop
keymap("", "<Space>", "<Nop>", opts)
keymap("", "<Up>",  "<Nop>",  opts)
keymap("", "<Down>", "<Nop>", opts)
keymap("", "<Left>", "<Nop>", opts)
keymap("", "<Right>", "<Nop>", opts)

keymap("i", "jj", "<ESC>",  opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<ESC><ESC>", ":nohlsearch<CR>", opts)
keymap("n", "sh", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)
-- S-v Shift-v
keymap("n", "<C-a>", "gg<S-v>G", opts)
-- Do not yank with x
keymap("n", "x", '"_x', opts)
-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)
-- ;でコマンド入力( ;と:を入れ替)
keymap("n", ";", ":", opts)
-- 行の端に行く
keymap("n", "<Space>h", "^", opts)
keymap("n", "<Space>l", "$", opts)
-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)
-- <Space>q で強制終了
keymap("n", "<Space>q", ":<C-u>q!<Return>", opts)
-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)
-- コンマの後に自動的にスペースを挿入
--keymap("i", ",", ",<Space>", opts)
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
-- ビジュアルモード時vで行末まで選択
keymap("v", "v", "$h", opts)
-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)


--local 

-- leader key設定
-- https://original-game.com/mini_howto/how-to-use-the-leader-key-in-vim/
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Visual --


--" 履歴コマンドのフィルタリング適応
--cnoremap <C-p> <Up>
--cnoremap <C-n> <Down>
--cnoremap <C-e> <End>
--cnoremap <C-b> <Left>
--cnoremap <C-f> <Right>
--cnoremap <C-d> <Del>
--" cnoremap <C-a> <Home>
--
--inoremap <silent> jj <ESC>
--
--nnoremap t <Nop>
--nnoremap tj <C-w>j
--nnoremap tk <C-w>k
--nnoremap tl <C-w>l
--nnoremap th <C-w>h
--nnoremap tJ <C-w>J
--nnoremap tK <C-w>K
--nnoremap tL <C-w>L
--nnoremap tH <C-w>H
--nnoremap tn gt
--nnoremap tp gT
--nnoremap ts :<C-u>sp<CR>
--nnoremap tv :<C-u>vs<CR>
--nnoremap tt :<C-u>tabnew<CR>
--nnoremap tw <C-w>
--
--" ターミナルモード
--tnoremap <silent> <ESC> <C-\><C-n>



