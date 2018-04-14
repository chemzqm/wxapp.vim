
" generate folder and related files
function! wxapp#generate(folder, name) abort
  let g:name = a:name
  if a:name !~ '^\(\w\|-\)\+$'
    echohl Error | echon '文件名非法' | echohl None
    return
  endif
  let path = simplify(getcwd().'/'.a:folder.'/'.a:name)
  if isdirectory(path) || filereadable(path)
    echohl Error | echon '目录已存在' | echohl None
  elseif exists('*mkdir')
    call mkdir(path, 'p')
    call s:system('touch '.path.'/'.a:name.'.wxml')
    call s:system('touch '.path.'/'.a:name.'.wxss')
    call s:system('touch '.path.'/'.a:name.'.js')
    execute 'edit '.path.'/'.a:name.'.js'
    execute 'belowright vs'.path.'/'.a:name.'.wxss'
    execute 'split '.path.'/'.a:name.'.wxml'
    execute 'wincmd h'
  endif
endfunction

function! wxapp#start() abort
  if !has("mac") | return | endif
  call s:osascript(
    \'tell application "wechatwebdevtools"',
    \  'activate',
    \'end tell')
endfunction

function! s:osascript(...) abort
  let args = join(map(copy(a:000), '" -e ".shellescape(v:val)'), '')
  call  s:system('osascript'. args)
  return !v:shell_error
endfunction

function! s:system(cmd)
  let output = system(a:cmd)
  if v:shell_error
    if output =~ '2700'
      echohl Error | echon '请先启动微信开发者工具' | echohl None
      return
    else
      echohl Error | echon output | echohl None
      return
    endif
  endif
  return output
endfunction

function! wxapp#open_related() abort
  let name = expand('%:t:r')
  let root = expand('%:p:h')
  let lines = ['a '.name.'.wxml',
        \'b '.name.'.wxss',
        \'c '.name.'.js',
        \'d '.name.'.json']
  execute 'keepalt below 4new [switch file]'
  call setline(1, lines[0])
  call append(1, lines[1:])
  setl filetype=runresult buftype=nofile bufhidden=wipe nobuflisted readonly
  if !has('gui_running')
    redraw
  endif
  exe 'nnoremap <buffer> <silent> a :call <SID>editFile("'.root.'/'.name.'.wxml")<cr>'
  exe 'nnoremap <buffer> <silent> b :call <SID>editFile("'.root.'/'.name.'.wxss")<cr>'
  exe 'nnoremap <buffer> <silent> c :call <SID>editFile("'.root.'/'.name.'.js")<cr>'
  exe 'nnoremap <buffer> <silent> d :call <SID>editFile("'.root.'/'.name.'.json")<cr>'
  exe 'nnoremap <buffer> <silent> q :quit<cr>'
  exe 'nnoremap <buffer> <silent> <enter> :call <SID>open("'.root.'")<cr>'
  exe 'nnoremap <buffer> <silent> t :call <SID>tabEdit("'.root.'")<cr>'
  exe 'nnoremap <buffer> <silent> s :call <SID>splitEdit("'.root.'", 0)<cr>'
  exe 'nnoremap <buffer> <silent> v :call <SID>splitEdit("'.root.'", 1)<cr>'
  syntax clear
  syn match wxAction /^\w/
  hi def link wxAction Label
endfunction

function! s:editFile(file)
  exe 'q'
  exe 'edit '.a:file
endfunction

function! s:open(root)
  let line = getline('.')
  exe 'q'
  exe 'edit '.a:root.'/'.line[2:]
endfunction

function! s:tabEdit(root)
  let line = getline('.')
  exe 'q'
  exe 'tabe '.a:root.'/'.line[2:]
endfunction

function! s:splitEdit(root, vertical)
  let line = getline('.')
  exe 'q'
  let cmd = a:vertical ? 'vsplit' : 'split'
  exe cmd.' '.a:root.'/'.line[2:]
endfunction
