" Vim compiler file
" Compiler:             C2c Compiler
" Maintainer:           Bas van den Berg
" Latest Revision:      03 October 2018

if exists("current_compiler")
  finish
endif
let current_compiler = "c2c"

if exists(':CompilerSet') != 2 " older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo&vim

CompilerSet makeprg=c2c

CompilerSet errorformat=
      \%*[^\"]\"%f\"%*\\D%l:%c:\ %m,
      \%*[^\"]\"%f\"%*\\D%l:\ %m,
      \\"%f\"%*\\D%l:%c:\ %m,
      \\"%f\"%*\\D%l:\ %m,
      \%-G%f:%l:\ %trror:\ (Each\ undeclared\ identifier\ is\ reported\ only\ once,
      \%-G%f:%l:\ %trror:\ for\ each\ function\ it\ appears\ in.),
      \%f:%l:%c:\ %trror:\ %m,
      \%f:%l:%c:\ %tarning:\ %m,
      \%f:%l:%c:\ %m,
      \%f:%l:\ %trror:\ %m,
      \%f:%l:\ %tarning:\ %m,
      \%f:%l:\ %m,
      \%f:\\(%*[^\\)]\\):\ %m,
      \\"%f\"\\,\ line\ %l%*\\D%c%*[^\ ]\ %m,
      \%D%*\\a[%*\\d]:\ Entering\ directory\ [`']%f',
      \%X%*\\a[%*\\d]:\ Leaving\ directory\ [`']%f',
      \%D%*\\a:\ Entering\ directory\ [`']%f',
      \%X%*\\a:\ Leaving\ directory\ [`']%f',
      \%DMaking\ %*\\a\ in\ %f

if exists('g:compiler_gcc_ignore_unmatched_lines')
  CompilerSet errorformat+=%-G%.%#
endif

let &cpo = s:cpo_save
unlet s:cpo_save
