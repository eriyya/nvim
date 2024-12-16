-- List fuzzy finder
return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    priority = 100,
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })
      -- Load telescope extensions
      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')
    end,
  },
}
