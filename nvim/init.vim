let username = "hirotonaya"

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
execute 'set runtimepath+=' . '/Users/' . username . '/.cache/dein/repos/github.com/Shougo/dein.vim'

" Required:
if dein#load_state('/Users/' . username . '/.cache/dein')
  call dein#begin('/Users/' . username . '/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/' . username . '/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})

  "Add or remove your plugins here like this:
  "call dein#add('Shougo/neosnippet.vim')
  "call dein#add('Shougo/neosnippet-snippets')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

set number             "行番号を表示
set autoindent         "改行時に自動でインデントする
set tabstop=2          "タブを何文字の空白に変換するか
set shiftwidth=2       "自動インデント時に入力する空白の数
set expandtab          "タブ入力を空白に変換
set splitright         "画面を縦分割する際に右に開く
set clipboard=unnamed  "yank した文字列をクリップボードにコピー
set hls                "検索した文字をハイライトする

nnoremap ; :

"""""""""""""""""""""""""""
" tab
"""""""""""""""""""""""""""
function! s:my_tabline()  "{{{
	let s = ''
	for i in range(1, tabpagenr('$'))
		let bufnrs = tabpagebuflist(i)
		let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
		let no = i  " display 0-origin tabpagenr.
		let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
		let title = fnamemodify(bufname(bufnr), ':t')
		let title = '[' . title . ']'
		let s .= '%'.i.'T'
		let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
		let s .= no . ':' . title
		let s .= mod
		let s .= '%#TabLineFill# '
	endfor
	let s .= '%#TabLineFill#%T%=%#TabLine#'
	return s
endfunction "}}}

function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
nnoremap    [Tag]   <Nop>
nmap    t [Tag]


for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
map <silent> [Tag]c ;tablast <bar> tabnew<CR>
map <silent> [Tag]x ;tabclose<CR>
map <silent> [Tag]l ;tabnext<CR>
map <silent> [Tag]h ;tabprevious<CR>

"""""""""""""""""""""""""""
" keybindings
"""""""""""""""""""""""""""
nnoremap <C-a> 0
inoremap <C-a> <Esc>0<Insert>
nnoremap <C-e> <C-$>
inoremap <C-e> <Esc><C-$><Insert>

inoremap <silent> jj <ESC>
inoremap <C-d> pp '==================='<cr>pp<cr>
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
" fzf
"""""""""""""""""""""""""""
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>
" 現在カーソルの下にある単語で検索
nnoremap <C-f><C-f> :Rg <C-r>=expand("<cword>")<CR><CR>
" 基本的に新規タブで開く
let g:fzf_action = {
\ 'enter': 'tab split',
\ 'ctrl-v': 'vsplit'
\ }
"""""""""""""""""""""""""""
" color
"""""""""""""""""""""""""""
 highlight SpecialKey gui=bold guifg=#839496 guibg=#eee8d5
set list           " 不可視文字を表示
" 不可視文字の表示記号指定
set listchars=tab:>-,eol:↲,extends:❯,precedes:❮,trail:■

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
"""""""""""""""""""""""""""
" ステータスライン
"""""""""""""""""""""""""""
set laststatus=2
let g:airline_theme = 'minimalist'
let g:airline#extensions#default#layout = [
	\ [ 'a', 'c', 'y' ],
	\ [ 'z', 'b', 'error', 'warning']
	\ ]

"""""""""""""""""""""""""""
" ale
"""""""""""""""""""""""""""
let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['eslint'],
\  'ruby': ['rubocop'],
\  'go': ['gofmt'],
\}
let g:ale_fix_on_save = 1

"""""""""""""""""""""""""""
" coc
"""""""""""""""""""""""""""
" Go to definition
" nmap <silent> ii <Plug>(coc-definition)
nmap <silent> <C-i><C-i> <Plug>(coc-definition)
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"
set completeopt=longest,menuone

" Allow move cursor in the suggestions with Tab, ctrl-n/p, and arrows
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

inoremap <expr><cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" COC-VIM TAB SETTINGS END
let g:coc_start_at_startup = 0
autocmd VimEnter * CocStart


nnoremap gb :Git blame<CR>
