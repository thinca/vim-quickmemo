" unite source: quickmemo
" Version: 1.0
" Author : thinca <thinca+vim@gmail.com>
" License: zlib License

let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
\   'name': 'quickmemo',
\ }

function! s:unite_source.gather_candidates(args, context)
  return map(quickmemo#list(), '{
  \   "word": v:val[0] . ": " . v:val[1],
  \   "source": "quickmemo",
  \   "kind": "buffer",
  \   "action__buffer_nr": v:val[0],
  \ }')
endfunction

function! unite#sources#quickmemo#define()
  return s:unite_source
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
