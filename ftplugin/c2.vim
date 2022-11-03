" Only do this when not done yet for this buffer

setlocal makeprg=c2c

let g:c2vim_debug = get(g:, 'c2vim_debug', 0)

lua c2vim = require("c2vim")

command! -buffer -nargs=0 C2TagDef lua c2vim.getTagDef()

command! -buffer -nargs=1 C2SymbolDef lua c2vim.getSymbolDef("<args>")

