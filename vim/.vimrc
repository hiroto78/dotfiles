""""""""""""""""""""""""""""""""
" .vimrc
""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""
" vim の基本的な設定 はじめ
""""""""""""""""""""""""""""""""
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" tab の設定
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

let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
for n in range(1, 9)
	execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
"End of tab setting 上はわざとセミコロンとコロンを入れ替えている
map <silent> [Tag]c ;tablast <bar> tabnew<CR>
map <silent> [Tag]x ;tabclose<CR>
map <silent> [Tag]l ;tabnext<CR>
map <silent> [Tag]h ;tabprevious<CR>
"
filetype plugin indent off

" 行末、行頭の移動をlinuxと同じコマンドにする
nnoremap <C-a> 0
inoremap <C-a> <Esc>0<Insert>
nnoremap <C-e> <C-$>
inoremap <C-e> <Esc><C-$><Insert>
"カーソルから行末まで削除
nnoremap <C-k> d$
inoremap <C-k> <Esc>d$<Insert>
"コロンセミコロンの入れ替え
nnoremap ; :
nnoremap : ;
set nocompatible
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
" 画面表示の設定

set number         " 行番号を表示する
"set cursorline     " カーソル行の背景色を変える
"set cursorcolumn   " カーソル位置のカラムの背景色を変える
set laststatus=2   " ステータス行を常に表示
set cmdheight=2    " メッセージ表示欄を2行確保
"set showmatch      " 対応する括弧を強調表示
"showmatchがあまりにもハイライトされ、どちらにカーソルがいってるかわからないためコメントアウトで下を利用
let loaded_matchparen = 1
set helpheight=999 " ヘルプを画面いっぱいに開く
set list           " 不可視文字を表示
" 不可視文字の表示記号指定
set listchars=tab:>-,eol:↲,extends:❯,precedes:❮
set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=%l,%c%V%8P
" カーソル移動関連の設定

set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う

" ファイル処理関連の設定

set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set hidden     " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread   "外部でファイルに変更がされた場合は読みなおす
set nobackup   " ファイル保存時にバックアップファイルを作らない
set noswapfile " ファイル編集中にスワップファイルを作らない

" 検索/置換の設定

set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set gdefault   " 置換の時 g オプションをデフォルトで有効にする

" タブ/インデントの設定

set expandtab     " タブ入力を複数の空白入力に置き換える
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " 自動インデントでずれる幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set smartindent   " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set noeol   "最終行に改行をいれない

" OSのクリップボードをレジスタ指定無しで Yank, Put 出来るようにする
set clipboard=unnamed,unnamedplus
"↓マウスからのコピーを有効にするために外した
set mouse=v
" Windows でもパスの区切り文字を / にする
set shellslash
" インサートモードから抜けると自動的にIMEをオフにする
" set iminsert=2 " コメントアウト for mac
" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu wildmode=list:longest,full
" コマンドラインの履歴を10000件保存する
set history=10000
"ビープ音すべてを無効にする
set visualbell t_vb=
set noerrorbells

"拡張子ごとのタブなどの設定
" filetype プラグインによる indent を on にする
filetype plugin indent on

" vim のマウス操作
if has('mouse')
    set mouse=a
    if has('mouse_sgr')
        set ttymouse=sgr
    elseif v:version > 703 || v:version is 703 && has('patch632')
        set ttymouse=sgr
    else
        set ttymouse=xterm2
    endif
endif

""""""""""""""""""""""""""""""""
" vim の基本的な設定 おわり
""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""
" 基本的なNeoBundle はじめ
""""""""""""""""""""""""""""""""
" neobundle.vim
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()
endif

" NeoBundle はじめ
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
NeoBundle "ctrlpvim/ctrlp.vim"
NeoBundle 'vim-scripts/robokai'

" インデントの可視化
NeoBundle 'Yggdroot/indentLine'

" color schema
NeoBundle 'tomasr/molokai'
let g:molokai_original = 1
filetype plugin on
colorscheme molokai
set t_Co=256
syntax on
let g:molokai_original = 1
set background=dark

" ファイル開くのをツリー型に
NeoBundle 'scrooloose/nerdtree'

" Git, Ggrep が使える
NeoBundle 'tpope/vim-fugitive'
" grep検索の実行後にQuickFix Listを表示する
autocmd QuickFixCmdPost *grep* cwindow
" ステータス行に現在のgitブランチを表示する
set statusline+=%{fugitive#statusline()}
"

" 複数行のコメントアウト
" visual 選択後に ctrl - -
NeoBundle 'tomtom/tcomment_vim'

" endwise
" def や end を補完
NeoBundleLazy 'tpope/vim-endwise', {'autoload' : { 'insert' : 1,}}

" vim-autoclose
" 括弧を補完
NeoBundle 'Townk/vim-autoclose'

" Yankround
" コピペを使いまわせる
NeoBundle 'LeafCage/yankround.vim'
" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
"}}}

"" matchit
""なんか動いてない気がするので一旦コメントアウト
":source $VIMRUNTIMEmacros/matchit.vim

" neocomplete・neosnippet
if has('lua') " lua機能が有効になっている場合・・・・・・
    " コードの自動補完
    NeoBundle 'Shougo/neocomplete.vim'
    " スニペットの補完機能
    NeoBundle "Shougo/neosnippet"
    " スニペット集
    NeoBundle 'Shougo/neosnippet-snippets'
endif
" neocomplete・neosnippetの設定
if neobundle#is_installed('neocomplete.vim')
    " Vim起動時にneocompleteを有効にする
    let g:neocomplete#enable_at_startup = 1
    " smartcase有効化. 大文字が入力されるまで大文字小文字の区別を無視する
    let g:neocomplete#enable_smart_case = 1
    " 3文字以上の単語に対して補完を有効にする
    let g:neocomplete#min_keyword_length = 3
    " 区切り文字まで補完する
    let g:neocomplete#enable_auto_delimiter = 1
    " 1文字目の入力から補完のポップアップを表示
    let g:neocomplete#auto_completion_start_length = 1
    " バックスペースで補完のポップアップを閉じる
    inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

    " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定・・・・・・②
    "imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "<C-y>" : "<CR>"
    " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ・・・・・・③
    "imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable() ? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"
endif

""""""""""""""""""""""""""""""""
" 基本的なNeoBundle おわり
""""""""""""""""""""""""""""""""
"
""""""""""""""""""""""""""""""""
" 基本的な Linter の設定はじめ
""""""""""""""""""""""""""""""""
" Rubocop
" gem install rubocop
NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby', 'javascript'] }
let g:syntastic_ruby_checkers = ['rubocop', 'eslint']

NeoBundle 'scrooloose/syntastic'
NeoBundle 'pmsorhaindo/syntastic-local-eslint.vim'

" ここから下は Syntastic のおすすめの設定
" ref. https://github.com/scrooloose/syntastic#settings

" エラー行に sign を表示
let g:syntastic_enable_signs = 1
" location list を常に更新
let g:syntastic_always_populate_loc_list = 0
" location list を常に表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時にチェックを実行する
let g:syntastic_check_on_open = 1
" :wq で終了する時もチェックする
let g:syntastic_check_on_wq = 0

""""""""""""""""""""""""""""""""
" 基本的な Linter の設定おわり
""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" Ruby や ROR のための設定はじめ
""""""""""""""""""""""""""""""
"" vim-rails
autocmd User Rails.view*                 NeoSnippetSource ~/.vim/snippet/ruby.rails.view.snip
autocmd User Rails.controller*           NeoSnippetSource ~/.vim/snippet/ruby.rails.controller.snip
autocmd User Rails/db/migrate/*          NeoSnippetSource ~/.vim/snippet/ruby.rails.migrate.snip
autocmd User Rails/config/routes.rb      NeoSnippetSource ~/.vim/snippet/ruby.rails.route.snip
""""""""""""""""""""""""""""""
" Ruby や ROR のための設定おわり
""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""
" JS のための設定はじめ
""""""""""""""""""""""""""""""
"react native
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
let g:jsx_ext_required = 0

"" tern (react)
NeoBundle 'marijnh/tern_for_vim', {
  \ 'build': {
  \   'others': 'npm install'
  \}}
""""""""""""""""""""""""""""""
" JS のための設定おわり
""""""""""""""""""""""""""""""


" NeoBundle おわり
call neobundle#end()
