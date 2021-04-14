" 文字コードをUFT-8に設定
set fenc=utf-8

" バックアップを作らない
set nobackup

" スワップファイルを作らない
set noswapfile

" 編集中のファイルが変更されたら自動で読み直す
set autoread

" バッファが編集中でもそのほかのファイルを開けるようにする
set hidden

" 入力中のコマンドをステータスに表示
set showcmd

set number
set cursorline
"set cursorcolumn
" 行末の１文字先までカーソルを移動できるようにする
set virtualedit=onemore
set visualbell
set showmatch
" ステータスラインを常に表示
set laststatus=2

" コマンドラインの補完
set wildmode=list:full

" indentのtab->spaceにする
set expandtab

" スペース何個分でタブと設定するか
set tabstop=8

" 入力時のスペース挿入
set softtabstop=4
" 自動インデント幅
set shiftwidth=4
set smarttab


" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan



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
