return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      no_italic = true,
    },
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    opts = {
      variant = 'main',
      disable_italics = true,
    },
  },
  {
    'EdenEast/nightfox.nvim',
    name = 'nightfox',
    priority = 1000,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
  },
  {
    'xiyaowong/transparent.nvim',
    opts = {
      extra_groups = {
        'NvimTreeNormal',
      },
    },
  },
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({
        default = true,
      })
    end,
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup({
        highlights = {},
        ---@diagnostic disable-next-line: missing-fields
        options = {
          diagnostics = 'nvim_lsp',
          indicator = {
            style = 'underline',
          },
        },
      })
    end,
  },
}
