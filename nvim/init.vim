runtime init/base.vim
runtime init/tab.vim
runtime init/coc.vim
runtime init/copilot.vim
runtime init/ale.vim
runtime init/search.vim
runtime init/statusline.vim

set number             "行番号を表示
set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする


"""""""""""""""""""""""""""
" keybindings
"""""""""""""""""""""""""""
nnoremap ; :
nnoremap <C-a> 0
inoremap <C-a> <Esc>0<Insert>
nnoremap <C-e> <C-$>
inoremap <C-e> <Esc><C-$><Insert>

inoremap <silent> jj <ESC>
inoremap <C-d> pp '==================='<cr>pp
nnoremap <C-k> d$
inoremap <C-k> <Esc>d$<Insert>

nnoremap <C-h> <C-w>w
nnoremap <C-l> <C-w><C-w>

nnoremap ; :
nnoremap : ;
set nocompatible

" tabnine は pumvisible()が効かないようなのでこれで対応
" inoremap <C-J> <C-Y>

"""""""""""""""""""""""""""
" setting
"""""""""""""""""""""""""""
set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=4     " 画面上でタブ文字が占める幅
set shiftwidth=4  " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set noeol   "最終行に改行をいれない
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う
" set spell
" set spelllang=en_us


highlight SpecialKey gui=bold guifg=#839496 guibg=#eee8d5
set list           " 不可視文字を表示
set listchars=tab:>-,eol:↲,extends:❯,precedes:❮,trail:■   " 不可視文字の表示記号指定

"""""""""""""""""""""""""""
" colorscheme
"""""""""""""""""""""""""""
"let g:molokai_original = 1
filetype plugin on
colorscheme hybrid
"set t_Co=256
syntax on
"let g:molokai_original = 1

"""""""""""""""""""""""""""
" git
"""""""""""""""""""""""""""
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow
" ステータス行に現在のgitブランチを表示する
" set statusline=%F%m%r%h%w%=\ %{fugitive#statusline()}\ [%{&ff}:%{&fileencoding}]\ [%Y]\ [%04l,%04v]\ [%l/%L]\ %{strftime(\"%Y/%m/%d\ %H:%M:%S\")}
" set statusline+=%{fugitive#statusline()}
" let g:airline#extensions#tabline#fnamemod = ':.'
" let g:airline#extensions#tabline#fnamecollapse = 0
"
"""""""""""""""""""""""""""
" side tree
"""""""""""""""""""""""""""
nnoremap <silent> <C-n><C-n> :NERDTreeToggle<CR>
nnoremap <silent> <C-m><C-m> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right"
" let NERDTreeMapOpenInTab='<ENTER>'
"
"""""""""""""""""""""""""""
" git 差分
"""""""""""""""""""""""""""
nmap gj <Plug>(signify-next-hunk)zz
" 前の差分箇所に移動
nmap gk <Plug>(signify-prev-hunk)zz
nnoremap gb :Git blame<CR>
