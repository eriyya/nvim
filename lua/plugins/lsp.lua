return {
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'neovim/nvim-lspconfig' },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'windwp/nvim-autopairs',
        opts = {
          fast_wrap = {},
          disable_filetype = { 'TelescopePrompt', 'vim' },
        },
        config = function(_, opts)
          require('nvim-autopairs').setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require('nvim-autopairs.completion.cmp')
          require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
        end,
      },
      {
        'j-hui/fidget.nvim',
        tag = 'legacy',
        event = 'LspAttach',
        config = function()
          require('fidget').setup({
            window = {
              blend = 0,
            },
          })
        end,
      },

      -- Additional lua configuration, makes nvim stuff amazing!
      { 'folke/neodev.nvim', opts = {} },
    },
  },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'L3MON4D3/LuaSnip' },
  { 'saadparwaiz1/cmp_luasnip' },
  -- Code Action floating window
  { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },
  -- LSP Diagnostic
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },
  -- Commenting
  {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end,
  },
  { 'onsails/lspkind.nvim' },
  { 'f3fora/cmp-spell' },
}
