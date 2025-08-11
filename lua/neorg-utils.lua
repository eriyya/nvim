local M = {}

M.neorg_telescope_workspaces = function()
  local pickers = require('telescope.pickers')
  local sorters = require('telescope.sorters')
  local finders = require('telescope.finders')
  local actions = require('telescope.actions')
  local action_state = require('telescope.actions.state')
  local themes = require('telescope.themes')

  ---@diagnostic disable-next-line: undefined-field
  local workspaces = require('neorg').config.modules['core.dirman'].workspaces or {}
  pickers
    .new(themes.get_dropdown({ previewer = false }), {
      prompt_title = 'Neorg Workspaces',
      sorter = sorters.get_generic_fuzzy_sorter({}),
      finder = finders.new_table({
        results = vim.tbl_keys(workspaces),
      }),
      attach_mappings = function(bufnr)
        actions.select_default:replace(function()
          actions.close(bufnr)
          local selection = action_state.get_selected_entry()
          vim.cmd([[Neorg workspace ]] .. selection[1])
        end)
        return true
      end,
    })
    :find()
end

M.neorg_markdown_preview = function(suffix, open_preview)
  local dst = vim.fn.fnamemodify(vim.fn.expand('%'), ':~:.:r') .. suffix -- same name but with suffix
  vim.cmd(string.format([[Neorg export to-file %s]], string.gsub(dst, ' ', [[\ ]])))
  vim.schedule(function()
    vim.cmd.edit(dst)
    if suffix == '.md' and open_preview then
      vim.cmd([[MarkdownPreview]]) -- https://github.com/iamcco/markdown-preview.nvim
    end
  end)
end

return M
