require('mason').setup()

local servers = {
    'bashls',
    'lua_ls',
    'rust_analyzer',
    'tsserver',
    'eslint',
    'elixirls',
    'clangd',
    'omnisharp', -- C#
    -- 'omnisharp_mono', -- C# mono runtime
    'gopls',
    'taplo'
}

local server_config = require('lua/lsp/server_config').server_config

require('mason-lspconfig').setup({
    ensure_installed = servers
})

local cmp = require('cmp')
local lspkind = require('lspkind')

-- List of sources to exclude from special formatting
local exlude_fmt = {
    rust_analyzer = true,
}

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    formatting = {
        format = lspkind.cmp_format({
            mode = 'symbol',
            maxwidth = 50,
            ellipsis_char = '...',
            before = function(entry, vim_item) -- Customize completion result items
                pcall(function()
                    local item = entry:get_completion_item()
                    if exlude_fmt[entry.source.source.client.name] == nil and item.detail then
                        vim_item.menu = item.detail
                    end
                end)
                return vim_item
            end
        })
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4), -- Up
        ['<C-d>'] = cmp.mapping.scroll_docs(4),  -- Down
        -- C-b (back) C-f (forward) for snippet placeholder navigation.
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
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
        { name = 'copilot',  group_index = 2 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'path',     group_index = 2 },
        { name = 'luasnip',  group_index = 2 }
    }
})

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- cmp.setup.cmdline(':', {
--     mapping = cmp.mapping.preset.cmdline(),
--     sources = {
--         { name = 'buffer' }
--     }
-- })

-- Setup language servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')
for _, lsp in ipairs(servers) do
    local conf = { capabilities = capabilities }
    if server_config[lsp] then
        conf = vim.tbl_deep_extend('keep', conf, server_config[lsp])
    end
    lspconfig[lsp].setup(conf)
end


local signs = { Info = "", Warn = "", Error = "", Hint = "" }
local virtual_icons = {
    [vim.diagnostic.severity.INFO] = signs.Info,
    [vim.diagnostic.severity.WARN] = signs.Warn,
    [vim.diagnostic.severity.ERROR] = signs.Error,
    [vim.diagnostic.severity.HINT] = signs.Hint,
}

for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

vim.diagnostic.config({
    virtual_text = {
        prefix = '',
        format = function(diagnostic)
            local severity = diagnostic.severity
            local icon = virtual_icons[severity]
            return icon .. ' ' .. diagnostic.message
        end
    },
    severity_sort = true,
    float = {
        source = "always"
    }
})
