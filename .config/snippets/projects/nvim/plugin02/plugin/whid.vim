" FileName: whid
" Author: 8ucchiman
" CreatedDate: 2023-03-26 22:02:33 +0900
" LastModified: 2023-03-26 22:03:17 +0900
" Reference: 8ucchiman.jp
"


if exists('g:loaded_whid') | finish | endif " prevent loading file twice

let s:save_cpo = &cpo
" https://vi.stackexchange.com/questions/2116/is-cpovim-a-special-syntax
set cpo&vim


" highlight setting
hi def link WhidHeader      Number
hi def link WhidSubHeader   Identifier
" hi WhidCursorLine ctermbg=238 cterm=none

command! Whid lua require'whid'.whid()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_whid = 1
