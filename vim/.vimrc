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
set tabstop=4     " 画面上でタブ文字が占める幅
set shiftwidth=4  " 自動インデントでずれる幅
set softtabstop=4 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.jpg,*.png
let g:ctrlp_custom_ignore = '\v[\/](node_modules|build|local)$'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" let g:ctrlp_use_caching=0
" let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g'
NeoBundle 'vim-scripts/robokai'
NeoBundle 'crontab/robokai'

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
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle "Shougo/neosnippet"
" スニペット集
NeoBundle 'Shougo/neosnippet-snippets'
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'perl': $HOME. '/.perl.dict',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
" inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
" function! s:my_cr_function()
"   return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
"   " For no inserting <CR> key.
"   "return pumvisible() ? "\<C-y>" : "\<CR>"
" endfunction
" <TAB>: completion.
 inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
inoremap <expr><C-j> pumvisible() ? "\<C-y>" : "\<CR>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" Plugin key-mappings.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

NeoBundle 'rking/ag.vim'
NeoBundle 'Shougo/vimproc.vim'

" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> <C-c><C-c>  :<C-u>Unite grep:. -buffer-name=search-buffer<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> <C-f><C-f> :<C-u>Unite grep:. -default-action=tabopen -buffer-name=search-buffer<CR><C-R><C-W>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
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
"NeoBundle 'pmsorhaindo/syntastic-local-eslint.vim'
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_python_checkers = ['flake8']

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_enable_perl_checker = 1
let g:syntastic_perl_checkers = ['perl', 'podchecker']


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
NeoBundle 'vim-perl/vim-perl'

" NeoBundle おわり
call neobundle#end()

set tags=.tags
nnoremap <c-i><c-i> :tab tag <c-r><c-w><cr>
