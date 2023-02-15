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
\ 'ctrl-v': 'vsplit',
\ 'ctrl-h': 'split'
\ }
