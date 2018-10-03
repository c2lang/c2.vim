if exists("g:c2_loaded")
  finish
endif
let g:c2_loaded = 1

function! s:fmt_autosave()
  if get(g:, "c2_fmt_autosave", 1)
    call c2#fmt#Format()
  endif
endfunction

compiler c2c

"augroup vim-c2
"  autocmd!
"  autocmd BufWritePre *.c2 call s:fmt_autosave()
"augroup end

" vim: sw=2 ts=2 et
