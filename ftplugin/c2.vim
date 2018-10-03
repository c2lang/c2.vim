" Only do this when not done yet for this buffer

compiler c2c

if (exists("b:did_ftplugin"))
  finish
endif

let b:did_ftplugin = 1

set expandtab
set tabstop=4
set shiftwidth=4

setlocal suffixesadd=.c2
setlocal commentstring=//\ %s
setlocal makeprg=c2c
