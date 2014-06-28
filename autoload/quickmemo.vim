" Change an empty buffer to a memo buffer.
" Version: 1.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

let s:save_cpo = &cpo
set cpo&vim

let s:memo_buffers = {}

function! quickmemo#open()
  if exists('b:quickmemo_buffer') || bufname('%') !=# '' || &l:buftype !=# ''
    return
  endif
  let b:quickmemo_buffer = 1
  let s:memo_buffers[bufnr('%')] = ''
  setlocal buftype=nofile nobuflisted noswapfile bufhidden=hide
  augroup plugin-quickmemo-buffer
    autocmd! * <buffer>
    autocmd BufLeave <buffer> let s:memo_buffers[bufnr('%')] = getline(1)
    autocmd BufWriteCmd <buffer> call s:on_BufWriteCmd()
  augroup END
endfunction

function! quickmemo#open_list_buffer()
  new `='quickmemo://list'`
  setlocal buftype=nofile nobuflisted noswapfile bufhidden=hide
  silent % delete _
  let lines = values(map(copy(s:memo_buffers), 'v:key . ": " . v:val'))
  silent put =lines
  silent 1 delete _
  nnoremap <buffer> <Plug>(quickmemo-open)
  \                 :<C-r>=matchstr(getline('.'), '^\d\+')<CR>buffer<CR>
  nmap <buffer> <CR> <Plug>(quickmemo-open)

  setlocal readonly nomodifiable
endfunction

function! quickmemo#list()
  return items(s:memo_buffers)
endfunction

function! s:on_BufWriteCmd()
  silent! setl buftype< buflisted< swapfile< bufhidden< nomodified
  autocmd! plugin-quickmemo-buffer * <buffer>
  if bufname('%') ==# '' && exists('b:quickmemo_buffer')
    execute 'saveas' . (v:cmdbang ? '!' : '') ' <afile>'
    filetype detect
  endif
  unlet! b:quickmemo_buffer
  call remove(s:memo_buffers, bufnr('%'))
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
