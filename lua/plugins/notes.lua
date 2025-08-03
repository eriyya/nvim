return {
  'nvim-neorg/neorg',
  lazy = true,
  ft = 'norg',
  cmd = 'NeorgWorkspace',
  version = '*', -- Pin Neorg to the latest stable release
  config = function()
    require('neorg').setup({
      load = {
        ['core.defaults'] = {},
        ['core.dirman'] = {
          config = {
            workspaces = {
              notes = '~/notes',
              work = '~/work',
            },
            default_workspace = 'notes',
          },
        },
        ['core.qol.todo_items'] = {},
        ['core.esupports.indent'] = {},
        ['core.concealer'] = {
          config = {
            icon_preset = 'varied',
          },
        },
      },
    })

    vim.api.nvim_create_autocmd('BufEnter', {
      group = 'Neorg',
      pattern = '*.norg',
      desc = 'Setup buffer settings for Norg files',
      callback = function()
        vim.keymap.set(
          'n',
          '<leader>t',
          '<Plug>(neorg.qol.todo-items.todo.task-cycle)',
          { buffer = true }
        )
      end,
    })
  end,
}
