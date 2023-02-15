let username = "hiroto.naya"

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
