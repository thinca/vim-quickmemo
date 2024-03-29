" Change an empty buffer to a memo buffer.
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

if exists('g:loaded_quickmemo')
  finish
endif
let g:loaded_quickmemo = 1

command! QuickMemoList call quickmemo#open_list_buffer()

augroup plugin-quickmemo
  autocmd!
  autocmd BufEnter * call quickmemo#open()
augroup END
