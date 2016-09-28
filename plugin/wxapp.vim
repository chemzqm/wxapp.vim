command! -nargs=+ -complete=dir Wxgen call s:generate(<f-args>)

nnoremap <silent> <plug>WxappReload :<C-u>call <SID>reload()<cr>

function! s:generate(...) abort
  if a:0 == 2
    call wxapp#generate(a:1, a:2)
  elseif a:0 == 1
    call wxapp#generate('.', a:1)
  endif
endfunction

function! s:reload() abort
  if &ft == 'wxml' || &ft == 'wxss'
    call wxapp#reload()
  else
    call wxapp#rebuild()
  end
endfunction
