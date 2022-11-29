" 基本設定
set number " 行の表示
set nobackup " バックアップファイル、スワップファイルの設定(同じディレクトリに配下)
set noswapfile " バックアップファイル、スワップファイルの設定(同じディレクトリに配下)
set autoread " 外部でファイルに変更がされた場合読み直し
set autoindent
syntax on " ハイライト
set hlsearch " ハイライト
"filetype plugin indent on
set expandtab " indentのtab->spaceにする
set tabstop=8 " スペース何個分でタブと設定するか
set softtabstop=4 " 入力時のスペース挿入
set shiftwidth=4 " 自動インデント幅
set smarttab
set cursorline " カーソルがある行にラインを入れ強調
set ignorecase " 検索パターンにおいて大文字と小文字の区別をしない
set virtualedit=onemore " 行末の1文字先までカーソルを移動できるように
set laststatus=2 " ステータスラインを常に表示 0: まったく表示しない 1: 
set wildmode=list:full " コマンドラインの補完
" guifont
"set guifont=Ricty-Regular:h16
" set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch " 検索文字列入力時に順次対象文字列にヒットさせる
set wrapscan " 検索時に最後まで行ったら最初に戻る
set hidden " 保存されていないファイルがあっても別のファイルを開くことができる
set showcmd " 入力中のコマンドを表示させることができる
set clipboard=unnamed " macのcliboardとyankを統一

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

