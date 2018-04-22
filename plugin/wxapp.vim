command! -nargs=+ -complete=dir Wxgen call s:generate(<f-args>)

function! s:generate(...) abort
  if a:0 == 2
    call wxapp#generate(a:1, a:2)
  elseif a:0 == 1
    call wxapp#generate('.', a:1)
  endif
endfunction

nnoremap <silent> <Plug>(WxOpenRelated) :<C-u>call wxapp#open_related()<CR>
nnoremap <silent> <Plug>(WxOpenDash) :<C-u>call wxapp#open_dash()<CR>
