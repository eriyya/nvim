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

vim.api.nvim_create_user_command('FitContent', cmd_fit_content, {})

-- Change theme command
vim.api.nvim_create_user_command('Themes', function()
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  require('telescope.builtin').colorscheme({
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        if selection == nil then
          return
        end

        actions.close(prompt_bufnr)
        vim.cmd('colorscheme ' .. selection.value)
        vim.settings.theme = selection.value
        require('settings').save()
      end)
      return true
    end,
  })
end, {})

local function cmd_install_formatters()
  local formatters = require('lsp.server_config').formatters
  require('lsp.formatting').install_formatters(formatters)
end

vim.api.nvim_create_user_command('InstallFormatters', cmd_install_formatters, {})

local function get_git_user()
  require('plenary.job')
    :new({
      command = 'git',
      args = { 'config', '--global', 'user.email' },
      on_stdout = function(_, data)
        print(data)
      end,
    })
    :start()
end

vim.api.nvim_create_user_command('Me', get_git_user, {})

-- local pickers = require('telescope.pickers')
-- local sorters = require('telescope.sorters')
-- local finders = require('telescope.finders')

-- Custom picker to quickly switch between bookmarked directories (using naka)
-- vim.api.nvim_create_user_command('Naka', function()
--   local actions = require('telescope.actions')
--   local action_state = require('telescope.actions.state')
--   local opts = require('telescope.themes').get_dropdown()
--   pickers
--     .new({
--       results_title = 'Naka - Bookmarks',
--       finder = finders.new_oneshot_job({ 'naka-bin', '-d' }, {}),
--       sorter = sorters.get_generic_fuzzy_sorter(),
--       attach_mappings = function(prompt_bufnr, _)
--         actions.select_default:replace(function()
--           actions.close(prompt_bufnr)
--           local selection = action_state.get_selected_entry()[1]
--           vim.cmd.cd(selection)
--         end)
--         return true
--       end,
--     }, opts)
--     :find()
-- end, {})
