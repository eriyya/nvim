return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        no_italic = true,
        integrations = {
          telescope = {
            enabled = true,
          },
          neotree = true,
          -- cmp = true,
          gitsigns = true,
          treesitter = true,
          treesitter_context = true,
          snacks = true,
        },
        transparent_background = true,
        color_overrides = {
          mocha = {
            base = '#08080d',
            mantle = '#08080d',
            crust = '#08080d',
          },
        },
        custom_highlights = function()
          return {
            CursorLine = { bg = '#11111b' },
          }
        end,
      })
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    -- priority = 1000,
    opts = {
      variant = 'main',
      disable_italics = true,
      disable_background = true,
      disable_float_background = true,
    },
  },
  {
    lazy = false,
    priority = 1000,
    'neanias/everforest-nvim',
    config = function()
      require('everforest').setup({
        transparent_background_level = 1,
      })
    end,
  },
  -- Toggleable transparent background
  {
    'xiyaowong/transparent.nvim',
    opts = {
      extra_groups = {
        'NeoTreeNormal',
        'NeoTreeNormalNC',
      },
    },
  },
  -- Additional icons
  {
    'nvim-tree/nvim-web-devicons',
  },
  -- Extra color support for themes with missing lsp higlights
  { 'folke/lsp-colors.nvim' },
}
