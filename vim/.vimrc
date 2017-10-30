"start of tab setting
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

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

map <silent> [Tag]c ;tablast <bar> tabnew<CR>
map <silent> [Tag]x ;tabclose<CR>
map <silent> [Tag]l ;tabnext<CR>
map <silent> [Tag]h ;tabprevious<CR>
"End of tab setting 上はわざとセミコロンとコロンを入れ替えている

"imap = 
"imap =

" neobundle.vim
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()
endif

NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc'
NeoBundle 'git://github.com/thinca/vim-quickrun.git'
NeoBundle "ctrlpvim/ctrlp.vim"
NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/robokai'
filetype plugin on
colorscheme molokai
set t_Co=256
syntax on
let g:molokai_original = 1
set background=dark

" /neobundle.vim
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
NeoBundle 'tomtom/tcomment_vim'
"
""""""""""""""""""""""""""""""
" Ruby on rails のための設定
""""""""""""""""""""""""""""""
"
"
""""""""""""""
" Rubocop
""""""""""""""
NeoBundle 'scrooloose/syntastic'
" gem install rubocop
NeoBundle 'scrooloose/syntastic'
let g:syntastic_mode_map = { 'mode': 'active', 'active_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']
""""""""""""""
" endwise
""""""""""""""
NeoBundleLazy 'tpope/vim-endwise', {'autoload' : { 'insert' : 1,}}

""""""""""""""
" vim-autoclose
""""""""""""""
NeoBundle 'Townk/vim-autoclose'
""""""""""""""
" neocomplete
""""""""""""""
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif

" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
"let g:neocomplete#use_vimproc                     = 1 "なんかエラーでる
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}

"""""""""""""""
"" Yankround
"""""""""""""""
NeoBundle 'LeafCage/yankround.vim'
" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
"}}}

"""""""""""""""
"" matchit
"""""""""""""""
":source $VIMRUNTIMEmacros/matchit.vim "なんか動いてない気がする

"""""""""""""""
"" vim-rails
"""""""""""""""
autocmd User Rails.view*                 NeoSnippetSource ~/.vim/snippet/ruby.rails.view.snip
autocmd User Rails.controller*           NeoSnippetSource ~/.vim/snippet/ruby.rails.controller.snip
autocmd User Rails/db/migrate/*          NeoSnippetSource ~/.vim/snippet/ruby.rails.migrate.snip
autocmd User Rails/config/routes.rb      NeoSnippetSource ~/.vim/snippet/ruby.rails.route.snip




"""""""""""""""
"" Rsense
"""""""""""""""
"" dein
"" Vim起動完了時にインストール
"augroup PluginInstall
"  autocmd!
"  autocmd VimEnter * if dein#check_install() | call dein#install() | endif
"augroup END
"
"" 各プラグインをインストールするディレクトリ
"let s:plugin_dir = expand('~/.vim/')
"
"" dein.vimをインストールするディレクトリをランタイムパスへ追加
"let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
"execute 'set runtimepath+=' . s:dein_dir
"
"" dein.vimがまだ入ってなければ 最初に git clone
"if !isdirectory(s:dein_dir)
"  call mkdir(s:dein_dir, 'p')
"  silent execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', s:dein_dir)
"endif
"
""dein plugin settings
"if dein#load_state(s:plugin_dir)
"  call dein#begin(s:plugin_dir)
"endif
"
"" ここからインストールするプラグイン
"call dein#add('Shougo/dein.vim')
"call dein#add('Shougo/neocomplcache.vim')
"call dein#add('Shougo/neocomplcache-rsense.vim')
"
"
"" neocomplcacheの設定
"" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
"
"" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
"
"" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
"
"" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"
"let g:neocomplcache_enable_camel_case_completion = 1
"let g:neocomplcache_enable_underbar_completion = 1
"
"
"" Rsense用の設定
"if !exists('g:neocomplcache_omni_patterns')
"    let g:neocomplcache_omni_patterns = {}
"endif
"let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
"autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
"
""rsenseのインストールフォルダがデフォルトと異なるので設定
"let g:rsenseHome = expand("/home/newlight/.rbenv/shims/rsense")
"let g:rsenseUseOmniFunc = 1
