return {
  -- Cool themes
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
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      transparent = true,
    },
  },
  {
    'EdenEast/nightfox.nvim',
    name = 'nightfox',
    priority = 1000,
  },
  {
    'pineapplegiant/spaceduck',
    priority = 1000,
  },
  {
    'nyoom-engineering/oxocarbon.nvim',
    priority = 1000,
  },
  -- Toggleable transparent background
  {
    'xiyaowong/transparent.nvim',
    opts = {
      extra_groups = {
        'NvimTreeNormal',
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
