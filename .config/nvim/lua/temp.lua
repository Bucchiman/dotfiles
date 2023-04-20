local M = {}
local api = vim.api
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd


function M.term_split()
    vim.api.nvim_command('split | wincmd j | resize 10 | terminal')
end



-- 起動後にコールバック軌道
autocmd("VimEnter", {
    callback = M.term_split
    --command = 
})


return M
