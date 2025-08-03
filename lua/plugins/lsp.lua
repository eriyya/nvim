return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('lsp')
    end,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'onsails/lspkind.nvim',
      'nvimdev/lspsaga.nvim',
      {
        'j-hui/fidget.nvim',
        opts = {
          progress = {
            display = {
              render_limit = 3,
            },
          },
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
      -------------
      -- none-ls --
      -------------
      {
        'nvimtools/none-ls.nvim',
        dependencies = {
          'nvimtools/none-ls-extras.nvim',
        },
      },
      -----------
      -- Blink --
      -----------
      {
        'saghen/blink.cmp',
        dependencies = {
          {
            'folke/lazydev.nvim',
            ft = 'lua',
            opts = {
              library = {
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
              },
            },
          },
        },
        version = '1.*',
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
          keymap = {
            preset = 'super-tab',
            ['<C-j>'] = {
              function(cmp)
                cmp.show({})
              end,
            },
          },
          completion = { documentation = { auto_show = false } },
          appearance = {
            use_nvim_cmp_as_default = true,
            nerd_font_variant = 'normal',
          },
          sources = {
            default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
              lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                score_offset = 100,
              },
            },
          },

          fuzzy = { implementation = 'prefer_rust_with_warning' },
        },
        opts_extend = { 'sources.default' },
      },
      -------------
      -- Trouble --
      -------------
      {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {},
      },
    },
  },
}
