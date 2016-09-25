" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif

runtime! ftplugin/css.vim ftplugin/css_*.vim ftplugin/css/*.vim
unlet! b:did_ftplugin
