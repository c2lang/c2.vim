" Only do this when not done yet for this buffer

"compiler c2c

"setlocal suffixesadd=.c2
"setlocal commentstring=//\ %s
"setlocal makeprg=c2c

let g:c2vim_debug = get(g:, 'c2vim_debug', 0)

" This forces a reload of the plugin when we source it.
" Helps development times tremendously

lua<<EOF
-- uncomment below to allow "source %" to reload the plugin during development
-- require('plenary.reload').reload_module('c2vim', true)
EOF

lua c2vim = require("c2vim")

command! -buffer -nargs=0 C2TagResult lua c2vim.getTagResults()

