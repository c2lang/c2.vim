local scan = require("plenary.scandir")
utils = require("c2vim.utils")

local M = {}

function M.getTagResults()
    local line,col = unpack(vim.api.nvim_win_get_cursor(0))
    col = col + 1   -- col seems to be 0-based
    local current_file = vim.api.nvim_eval('expand("%:p")')
    print("file: " .. current_file .. " " .. line .. ":" .. col)
    -- TODO is current_file is fullname
    local path, filename, extension = utils.split_filename(current_file)

    utils.log("Currently working with:")
    print("Full Path: " .. path)
    print("Filename: " .. filename)
    print("Extension: " .. extension)

    --return matching_files
end

return M
