return {
  -- Language server installer
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({
        registries = {
          'github:mason-org/mason-registry',
          'github:Crashdummyy/mason-registry', -- roslyn.nvim
        },
      })
    end,
  },
  -- LSP configuration for mason
  { 'williamboman/mason-lspconfig.nvim' },
}
