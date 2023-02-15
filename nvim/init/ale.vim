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
