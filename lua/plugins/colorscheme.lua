return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
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
    'tiagovla/tokyodark.nvim',
    name = 'tokyodark',
    lazy = true,
    priority = 1000,
    opts = {
      transparent_background = true,
      styles = {
        comments = { italic = false }, -- style for comments
        keywords = { italic = false }, -- style for keywords
        identifiers = { italic = false }, -- style for identifiers
        functions = { italic = false }, -- style for functions
        variables = { italic = false }, -- style for variables
      },
    },
    config = function(_, opts)
      require('tokyodark').setup(opts) -- calling setup is optional
      vim.cmd([[colorscheme tokyodark]])
    end,
  },
  {
    'thesimonho/kanagawa-paper.nvim',
    lazy = true,
    priority = 1000,
    opts = {},
  },
  -- Toggleable transparent background
  -- {
  --   'xiyaowong/transparent.nvim',
  --   opts = {
  --     extra_groups = {
  --       'NeoTreeNormal',
  --       'NeoTreeNormalNC',
  --     },
  --   },
  -- },
  -- Additional icons
  {
    'nvim-tree/nvim-web-devicons',
  },
  -- Extra color support for themes with missing lsp higlights
  { 'folke/lsp-colors.nvim' },
}
