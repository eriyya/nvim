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
    require('none-ls.formatting.eslint_d'),
    require('none-ls.diagnostics.eslint_d'),
  },
})

local cmp = require('cmp')
local lspkind = require('lspkind')

-- List of sources to exclude from special formatting
local exclude_fmt = {
  rust_analyzer = true,
}

-- require('lsp.codelens')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  completion = { completeopt = 'menu,menuone,noinsert' },
  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      ellipsis_char = '...',
      before = function(entry, vim_item) -- Customize completion result items
        pcall(function()
          local item = entry:get_completion_item()
          if exclude_fmt[entry.source.source.client.name] == nil and item.detail then
            vim_item.menu = item.detail
          end
        end)
        return vim_item
      end,
    }),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
    ['<C-d>'] = cmp.mapping.scroll_docs(4), -- Down
    -- C-b (back) C-f (forward) for snippet placeholder navigation.
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
    ['<C-j>'] = function()
      if cmp.visible() then
        cmp.abort()
      else
        cmp.complete()
      end
    end,
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'lazydev', group_index = 0 },
    { name = 'copilot', group_index = 2 },
    { name = 'nvim_lsp', group_index = 2 },
    { name = 'path', group_index = 2 },
    { name = 'luasnip', group_index = 2 },
    {
      name = 'spell',
      option = {
        keep_all_entries = false,
        enable_in_context = function()
          return true
        end,
      },
    },
  },
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

-- cmp.setup.cmdline(':', {
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'path' },
--   }, {
--     { name = 'cmdline' },
--   }),
--   ---@diagnostic disable-next-line: missing-fields
--   matching = { disallow_symbol_nonprefix_matching = false },
-- })

-- Setup language servers
local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

local lspconfig = require('lspconfig')

for _, lsp in ipairs(servers) do
  local conf = { capabilities = capabilities }
  local lsp_conf = vim.tbl_deep_extend('keep', conf, server_config[lsp] or {})
  lspconfig[lsp].setup(lsp_conf)
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
  },
})

-- Snippets
require('luasnip.loaders.from_snipmate').lazy_load({ paths = { './snippets' } })
