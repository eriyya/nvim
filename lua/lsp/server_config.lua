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
  ts_ls = {
    settings = {
      single_file_support = true,
      diagnostics = {
        ignoredCodes = {
          80001,
        },
      },
    },
  },
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
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
  omnisharp = {
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

-- don't show parse errors in a separate window
vim.g.zig_fmt_parse_errors = 0

return M
