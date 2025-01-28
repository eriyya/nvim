return {
  'nvim-neorg/neorg',
  lazy = false,
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
  end,
}
