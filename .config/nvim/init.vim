" 行の表示
set number

" バックアップファイル、スワップファイルの設定(同じディレクトリに配下)
" set backup
set nobackup
set noswapfile

" 外部でファイルに変更がされた場合読み直し
set autoread

set autoindent

" ハイライト
"syntax on
"set hlsearch

"filetype plugin indent on

" indentのtab->spaceにする
set expandtab
" スペース何個分でタブと設定するか
set tabstop=8
" 入力時のスペース挿入
set softtabstop=4
" 自動インデント幅
set shiftwidth=4
set smarttab


" カーソルがある行にラインを入れ強調
set cursorline
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:full
" guifont
"set guifont=Ricty-Regular:h16


" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan


set hidden
" set showcmd

" キーマッピング系
" カーソルキー使用不可
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" 履歴コマンドのフィルタリング適応
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-e> <End>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <C-d> <Del>
" cnoremap <C-a> <Home>

inoremap <silent> jj <ESC>
" 文字検索のハイライト表示をESC連打でハイライト解除
nnoremap <ESC><ESC> :nohlsearch<CR>

nnoremap t <Nop>
nnoremap tj <C-w>j
nnoremap tk <C-w>k
nnoremap tl <C-w>l
nnoremap th <C-w>h
nnoremap tJ <C-w>J
nnoremap tK <C-w>K
nnoremap tL <C-w>L
nnoremap tH <C-w>H
nnoremap tn gt
nnoremap tp gT
nnoremap ts :<C-u>sp<CR>
nnoremap tv :<C-u>vs<CR>
nnoremap tt :<C-u>tabnew<CR>
nnoremap tw <C-w>

" ターミナルモード
tnoremap <silent> <ESC> <C-\><C-n>


"" Insert timestamp after 'LastModified: '
function! LastModified()
    if &modified
	let save_cursor = getpos(".")
	let n = min([40, line("$")])
	keepjumps exe '1,' . n . 's#^\(.\{,10}LastModified: \).*#\1' .
		    \ strftime('%Y-%m-%d %H:%M:%S %z') . '#e'
	call histdel('search', -1)
	call setpos('.', save_cursor)
    endif
endfun
autocmd BufWritePre * call LastModified()

" fzf: a general-purpose command-line fuzzy finder
set rtp+=/opt/local/share/fzf
" ; を押してbufferの選択
nmap ; :Buffers<CR>
" <C-t>を押してfileの選択
nmap <C-t> :Files<CR>
" <C-g><C-f>でgitのファイル選択
nmap <C-g><C-f> :GFiles?<CR>
" <C-g><C-h> で git の commit hash 選択して diff を表示
nmap <C-g><C-h> :Commits<CR>

let g:cache_home = empty($XDG_CACHE_HOME) ? expand('$HOME/.cache') : $XDG_CACHE_HOME " XDG_CACHE_HOME変数が存在すればcache扱い、そうでない場合ホームディレクトリ以下に.cacheを作る
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('$HOME/.config') : $XDG_CONFIG_HOME

let g:python3_host_prog = '/usr/bin/python3'

" dein
let s:dein_cache_dir = g:cache_home . '/dein'

" reset augroup
augroup MyAutoCmd
autocmd!
augroup END


" ~/.cache/dein/repos/github.com/Shougo/dein.vimをrtpに追加
if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

    " Auto Download
    if !isdirectory(s:dein_repo_dir)
        call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
    endif
    " rtpの先頭に追加
    execute 'set runtimepath^=' . s:dein_repo_dir
endif


" begin settings {{{
if dein#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)

    let s:toml_dir = g:config_home . "/dein"
    call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
    call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif
" }}}

" plugin installation check {{{
if has('vim_starting') && dein#check_install()
    call dein#install()
endif
" }}}

" plugin remove check {{{
let s:removed_plugins = dein#check_clean()
if len(s:removed_plugins) > 0
    echo s:removed_plugins
    call map(s:removed_plugins, "delete(v:val, 'rf')")
    call dein#recache_runtimepath()
endif
" }}}

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none 


" WSL clipboard
"if !empty($WSL_DISTRO_NAME)
"    let s:clip = '/mnt/c/Windows/System32/clip.exe'
"    if executable(s:clip)
"        augroup WSLYank
"            autocmd!
"            autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
"        augroup END
"    endif
"endif

" guifontを設定しないと文字化けになる。terminalで行ったフォントの設定と同様
" 公式サイトではLinuxとmacOSの設定が若干異なるが、Linuxの設定でもmacOSで問題なし
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 12
set encoding=utf-8

" フォルダアイコンを表示
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif
set clipboard=unnamed

