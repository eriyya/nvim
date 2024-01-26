local M = {}

local util = require('lspconfig/util')

M.server_config = {
  gopls = {
    cmd = { 'gopls', 'serve' },
    filetypes = { 'go', 'gomod' },
    root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
  },
  tailwindcss = {
    cmd = { 'tailwindcss-language-server', '--stdio' },
    filetypes = {
      'html',
      'css',
      'scss',
      'javascript',
      'javascriptreact',
      'typescript',
      'typescriptreact',
      'vue',
    },
    root_dir = util.root_pattern(
      'tailwind.config.js',
      'tailwind.config.ts',
      'postcss.config.js',
      'postcss.config.ts'
    ),
  },
  tsserver = {
    single_file_support = true,
  },
  ocamllsp = {
    get_language_id = function(_, ftype)
      return ftype
    end,
    on_attach = require('virtualtypes').on_attach,
    settings = {
      codelens = {
        enable = true,
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        hint = {
          enable = true,
          arrayIndex = 'Disable',
        },
        workspace = {
          checkThirdParty = false,
        },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'lowercase-global' },
        },
      },
    },
  },
  omnisharp_mono = {
    enable_roslyn_analyzers = true,
    enable_editor_config_support = true,
  },
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        check = {
          command = 'clippy',
        },
      },
    },
  },
}

M.formatters = {
  'stylua',
  'prettierd',
}

return M
