return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = true,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    lazy = true,
  },
  {
    'EdenEast/nightfox.nvim',
    name = 'nightfox',
    priority = 1000,
    lazy = true,
  },
  {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup({
        extra_groups = {
          'NvimTreeNormal',
        },
      })
    end,
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
