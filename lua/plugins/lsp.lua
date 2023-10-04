return {
  -- Language server installer
  { 'williamboman/mason.nvim' },
  -- LSP configuration for mason
  { 'williamboman/mason-lspconfig.nvim' },
  -- LSP
  { 'neovim/nvim-lspconfig' },
  -- Additional LSP support
  { 'jose-elias-alvarez/null-ls.nvim' },
  -- Virtual Types / Inlay hints (only used for some languages that don't natively support inlay hints yet)
  { 'jubnzv/virtual-types.nvim' },
  -- Completion engine
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- LSP status indicators
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
  -- LSP enhancements
  {
    'nvimdev/lspsaga.nvim',
  },
  -- LSP completion source for cmp
  { 'hrsh7th/cmp-nvim-lsp' },
  -- Snippets for lua
  { 'L3MON4D3/LuaSnip' },
  -- Snippets source for cmp
  { 'saadparwaiz1/cmp_luasnip' },
  -- Code Action floating window
  -- { 'weilbith/nvim-code-action-menu', cmd = 'CodeActionMenu' },
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
  -- Icons for LSP completion items
  { 'onsails/lspkind.nvim' },
  -- Spell checking sources for cmp
  { 'f3fora/cmp-spell' },
  -- OCaml runtime files
  { 'ocaml/vim-ocaml' },
}
