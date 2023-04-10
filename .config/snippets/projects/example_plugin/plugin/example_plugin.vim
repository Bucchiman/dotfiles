
" プラグインが二重に読み込まれるのを回避
if exists('g:loaded_example_plugin')
  finish
endif
let g:loaded_example_plugin = 1

" ファイル名#関数名
call example#IMEStateSaveEnable()

" コマンド登録
command! -nargs=0 IMEStateSaveEnable  call example#IMEStateSaveEnable()
command! -nargs=0 IMEStateSaveDisable call example#IMEStateSaveDisable()
command! -nargs=0 IMEStateSaveToggle  call example#IMEStateSaveToggle()

" neovimであれば
"if !has('nvim')
  command! -nargs=0 ExampleOpenWin  lua require("example").nvim_open_win()
"endif
