if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'wxml'
endif


runtime! syntax/xml.vim
unlet! b:current_syntax

syntax include @wxmlJavascript syntax/javascript.vim
syntax region wxs matchgroup=xmlTag start=/\v^\<wxs\s.+\>$/
\                 matchgroup=xmlTag end=/\v\<\/wxs\>/
\                 contains=@wxmlJavascript,xmlTag,xmlEndTag,@xmlPreproc
\                 containedin=xmlRegion
\                 contained

let b:current_syntax = "wxml"
if main_syntax == "wxml"
  unlet main_syntax
endif

" vim:set sw=2:
