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
      disable_background = true,
      disable_float_background = true,
    },
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
