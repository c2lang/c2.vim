utils = require('c2vim.utils')

local M = {}

function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

function split(s, delimiter)
    result = {}
    for match in (s..delimiter):gmatch('(.-)'..delimiter) do
        table.insert(result, match)
    end
    return result
end

function get_tag(cmd)
    res = os.capture(cmd, false)
    --print(res)
    local result = split(res, ' ')
    if (result[1] == 'no') then
        print('No symbol found')
        return
    end

    local dest_file = result[2]
    local dest_line = result[3] + 0
    local dest_col = result[4] - 1
    --print("FOUND: ".. dest_file .. " " .. dest_line .. " " .. dest_col )
    print(' '); -- otherwise shows :C2TagResult
    vim.cmd('e ' .. dest_file)
    vim.cmd('set so=999')
    vim.api.nvim_win_set_cursor(0, { dest_line, dest_col })
    vim.cmd('set so=0')
end

function M.getTagDef()
    local line,col = unpack(vim.api.nvim_win_get_cursor(0))
    col = col + 1   -- col seems to be 0-based
    local filename = vim.api.nvim_eval('expand("%")')

    local cmd = 'c2tags ' .. filename .. ' ' .. line .. ' ' .. col
    get_tag(cmd)
end

function M.getSymbolDef(symbol)
    local cmd = 'c2tags ' .. symbol
    get_tag(cmd)
end

return M

-- local cwd = vim.fn.getcwd()
-- local filename = string.sub(current_file, string.len(cwd) + 2)
-- word under cursor:
-- local symbol = vim.api.nvim_eval('expand("<cfile>")')

