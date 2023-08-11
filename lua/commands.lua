local function get_max_line(lines)
    local max_line = 0
    for _, line in ipairs(lines) do
        if #line > max_line then
            max_line = #line
        end
    end
    return max_line
end

local function cmd_fit_content()
    local curr_win = vim.api.nvim_get_current_win()
    local curr_buf = vim.api.nvim_get_current_buf()
    local buf_lines = vim.api.nvim_buf_get_lines(curr_buf, 0, -1, false)
    local max_line = get_max_line(buf_lines)
    vim.api.nvim_win_set_width(curr_win, max_line)
end

vim.api.nvim_create_user_command('WinFitContent', cmd_fit_content, {})

local tree = require('nvim-tree.api')
tree.events.subscribe(tree.events.Event.TreeOpen, function()
    vim.cmd.WinFitContent()
end)
