" Change an empty buffer to a memo buffer.
" Version: 1.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

if exists('g:loaded_quickmemo')
  finish
endif
let g:loaded_quickmemo = 1

let s:save_cpo = &cpo
set cpo&vim

command! QuickMemoList call quickmemo#open_list_buffer()

augroup plugin-quickmemo
  autocmd!
  autocmd BufEnter * call quickmemo#open()
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo
