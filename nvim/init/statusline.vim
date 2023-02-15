"""""""""""""""""""""""""""
" ステータスライン
"""""""""""""""""""""""""""
set laststatus=2
let g:airline_theme = 'minimalist'
let g:airline#extensions#default#layout = [
    \ [ 'a', 'c', 'y' ],
    \ [ 'z', 'b', 'error', 'warning']
    \ ]
