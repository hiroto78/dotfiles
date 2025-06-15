"""""""""""""""""""""""""""
" ale
"""""""""""""""""""""""""""
let g:ale_enable = 1

let g:ale_linters = {
\   'ruby': ['rubocop'],
\}

" let g:ale_ruby_rubocop_options = '--disable Lint/Debugger'

let g:ale_fixers = {
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\  'javascript': ['eslint'],
\  'typescript': ['eslint', 'prettier'],
\  'ruby': ['rubocop'],
\  'go': ['gofmt'],
\}
let g:ale_fix_on_save = 1

let g:ale_log_level = 'debug'
let g:ale_history_log_output = 1
