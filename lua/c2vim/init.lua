local scan = require("plenary.scandir")
utils = require("c2vim.utils")

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
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match)
    end
    return result
end

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


function M.getTagResults()
    local line,col = unpack(vim.api.nvim_win_get_cursor(0))
    col = col + 1   -- col seems to be 0-based
    local filename = vim.api.nvim_eval('expand("%")')
    --local cwd = vim.fn.getcwd()
    --local filename = string.sub(current_file, string.len(cwd) + 2)

    local cmd = "c2tags " .. filename .. " " .. line .. " " .. col
    res = os.capture(cmd, false)
    --print(res)
    local result = split(res, ' ')
    if (result[1] == "no") then
        print("No symbol found")
        return
    end

    local dest_file = result[2]
    local dest_line = result[3] + 0
    local dest_col = result[4] - 1
    --print("FOUND: ".. dest_file .. " " .. dest_line .. " " .. dest_col )
    print(" "); -- otherwise shows :C2TagResult
    vim.cmd('e ' .. dest_file)
    vim.api.nvim_win_set_cursor(0, { dest_line, dest_col })
end

return M
