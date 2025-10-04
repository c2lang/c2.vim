if exists("g:c2_loaded")
  finish
endif
let g:c2_loaded = 1

function! s:fmt_autosave()
  if get(g:, "c2_fmt_autosave", 1)
    call c2#fmt#Format()
  endif
endfunction

function! GetTagResult()
  " get cursor position and word
  let l:src_file = bufname('%')
  let l:line = line('.')
  let l:column = col('.')

  " search reference destination
  let l:cmd = 'c2tags ' . l:src_file . ' ' . l:line . ' ' . l:column
  let l:cmd_ret = system(l:cmd)

  if l:cmd_ret[0] == 'n'
    echo 'no found'
    return
  endif
  let l:ret = substitute(l:cmd_ret, '[\]\|[[:cntrl:]]', '', 'g')
  " parse results
  let l:words = split(l:ret, ' ')
  "if match(l:words, 'error') != -1 
  if l:words[0] == 'e' 
      echo l:ret
      return
  endif
  "if match(l:words, 'multiple') != -1 
  if (l:words[0] == 'm')
      echo "multiple matches found. not supported yet"
      return
  endif
  if (len(l:words) != 4)
      "echo "no results found"
      return
  endif

  " otherwise c2tags returns: 'found file line col'
  let l:dst_file = l:words[1]
  let l:dst_line = l:words[2]
  let l:dst_col = l:words[3]

  " add position to jumplist
  normal! m`

  let l:nr = bufnr("")
  if (l:src_file != l:dst_file)
      let l:nr = bufnr(l:dst_file, 1)
      "let l:nr = bufnr("bar.c2", 1)
      if (l:nr == -1)
          echo "error creating buffer"
          return
      endif
      execute ":buffer ".l:nr
  endif

  " TODO push to tag stack for Ctrl-T
  let l:res = setpos('.', [0, l:dst_line, l:dst_col, 0])
  if (l:res == -1)
      echo "c2tags: cannot set position to:" l:dst_file l:dst_line l:dst_col
      return
  endif
endfunction

augroup C2tagsOpt
    autocmd!
    au filetype c2 noremap <silent> <c-h> :call g:GetTagResult()<CR>
augroup END


"compiler c2c

"augroup vim-c2
"  autocmd!
"  autocmd BufWritePre *.c2 call s:fmt_autosave()
"augroup end

" vim: sw=2 ts=2 et
