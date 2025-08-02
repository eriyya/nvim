require('mason').setup()

local install = require('lsp.install')
local servers = install.language_servers

local util = require('util')
local server_config = require('lsp.server_config').server_config

local language_servers = {}
for _, ls in ipairs(servers) do
  if not util.table_contains(vim.settings.excluded_lsp or {}, ls) then
    table.insert(language_servers, ls)
  end
end

require('mason-lspconfig').setup({
  ensure_installed = language_servers,
  automatic_installation = { exclude = vim.settings.excluded_lsp or {} },
})

local null_ls = require('null-ls')

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettierd,
  },
})

for _, lsp in ipairs(servers) do
  local conf = server_config[lsp] or {}
  vim.lsp.config(lsp, conf)
  vim.lsp.enable(lsp)
end

local signs = { Info = '', Warn = '', Error = '', Hint = '' }
local virtual_icons = {
  [vim.diagnostic.severity.INFO] = signs.Info,
  [vim.diagnostic.severity.WARN] = signs.Warn,
  [vim.diagnostic.severity.ERROR] = signs.Error,
  [vim.diagnostic.severity.HINT] = signs.Hint,
}

for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
  virtual_text = {
    prefix = '',
    format = function(diagnostic)
      local severity = diagnostic.severity
      local icon = virtual_icons[severity]
      return icon .. ' ' .. diagnostic.message
    end,
  },
  severity_sort = true,
  float = {
    source = true,
  },
})

-- LSP Saga
require('lspsaga').setup({
  lightbulb = {
    enabled = false,
    sign = false,
    virtual_text = false,
  },
  finder = {
    -- layout = 'normal',
    methods = {
      tdr = 'textDocument/references',
      tds = 'textDocument/definition',
      tdi = 'textDocument/implementation',
    },
    keys = {
      toggle_or_open = { '<CR>', 'o' },
    },
  },
})

require('lsp.codelens')

-- Snippets
require('luasnip.loaders.from_snipmate').lazy_load({ paths = { './snippets' } })
