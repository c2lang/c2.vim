local M = {}

-- logs info to :messages if c2vim_debug is true
function M.log(v)
    if vim.g.c2vim_debug ~= 0 then
        print(v)
    end
end

-- quick and dirty means of doing a ternary in Lua
function M.ternary(condition, T, F)
    if condition then return T else return F end
end

-- Returns the Path, Filename, and Extension as 3 values
function M.split_filename(file)
    local path, filename, extension = string.match(file, "(.-)([^\\/]-)([^\\/%.]+)$")

    -- pop the "." off the end of the filename - wouldn't need if my regex were better
    filename = filename:sub(1,-2)

    return path, filename, extension
end

-- prints out tables similar to var_dump()
function M.dump(arr, indentLevel)
    local str = ""
    local indentStr = "#"

    if(indentLevel == nil) then
        print(print_r(arr, 0))
        return
    end

    for i = 0, indentLevel do
        indentStr = indentStr.."\t"
    end

    for index,value in pairs(arr) do
        if type(value) == "table" then
            str = str..indentStr..index..": \n"..print_r(value, (indentLevel + 1))
        else
            str = str..indentStr..index..": "..value.."\n"
        end
    end
    return str
end

function M.find(matching_files, filename, extension, desired_extension)
    for index, value in ipairs(matching_files) do
        local path, matched_filename, matched_extension = utils.split_filename(value)

        utils.log("Potential match: " .. filename .. "." .. matched_extension)
        if (matched_extension == desired_extension and matched_extension ~= extension) and
             filename == matched_filename then
            utils.log("Match found! Executing command: 'edit " .. matching_files[index] .."'")
            local command_string = "edit " .. matching_files[index]
            vim.cmd(command_string)
            return true
        end
    end
    return false
end

return M
