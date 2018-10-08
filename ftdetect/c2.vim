autocmd BufNewFile  *.c2 0r ~/.vim/pack/plugins/start/c2.vim/skeletons/skeleton.c2
autocmd BufNewFile  recipe.txt 0r ~/.vim/pack/plugins/start/c2.vim/skeletons/recipe.txt
au BufRead,BufNewFile *.c2     set filetype=c2
au BufRead,BufNewFile *.c2i    set filetype=c2
