#!/usr/bin/env lua
--
-- FileName:     init
-- Author: 8ucchiman
-- CreatedDate:  2023-03-26 11:40:26 +0900
-- LastModified: 2023-03-31 21:41:28 +0900
-- Reference: https://zenn.dev/hisasann/articles/neovim-settings-to-lua
--


--vim.api.nvim_command('set runtimepath^=/home/bucchiman/.config/snippets/codes/lua/nvim')
local home_dir = os.getenv('HOME')
--local cfg_dir = home_dir..'/.config/snippets/codes/lua/nvim'
--print(cfg_dir)
--vim.api.nvim_command('set runtimepath^='..cfg_dir)

--require("")


require("base")
require("options")
--require("plugins.packer")
require("plugins.lazy")
require("plugins.lspconfig")
require("keymaps")

-- Insert timestamp after 'LastModified: '
--function! LastModified()
--    if &modified
--	let save_cursor = getpos(".")
--	let n = min([40, line("$")])
--	keepjumps exe '1,' . n . 's#^\(.\{,10}LastModified: \).*#\1' .
--		    \ strftime('%Y-%m-%d %H:%M:%S %z') . '#e'
--	call histdel('search', -1)
--	call setpos('.', save_cursor)
--    endif
--endfun
--autocmd BufWritePre * call LastModified()

