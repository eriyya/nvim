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

vim.api.nvim_create_user_command('Fit', cmd_fit_content, {})

vim.api.nvim_create_user_command(
  'NeorgWorkspace',
  require('neorg-utils').neorg_telescope_workspaces,
  {}
)

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

vim.api.nvim_create_user_command('NeorgMarkdown', function()
  require('neorg-utils').neorg_markdown_preview('.md', true)
end, {})

vim.api.nvim_create_user_command('InstallServers', function()
  local lsp_install = require('lsp.install')
  lsp_install.mason_install(lsp_install.linters_and_formatters)
end, {})

local function get_git_user()
  require('plenary.job')
    ---@diagnostic disable-next-line: missing-fields
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
