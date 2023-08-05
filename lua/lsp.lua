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

local util = require('lspconfig/util')

local server_configs = {
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

    }
}

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

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Setup language servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')
for _, lsp in ipairs(servers) do
    local conf = { capabilities = capabilities }
    if server_configs[lsp] then
        conf = vim.tbl_deep_extend('keep', conf, server_configs[lsp])
    end
    lspconfig[lsp].setup(conf)
end

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Trouble Keybinds
vim.keymap.set("n", "<space>q", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>xw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>xd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>xq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>xl", function() require("trouble").open("loclist") end)
-- vim.keymap.set("n", "gr", function() require("trouble").open("lsp_references") end)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
        vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
        vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
        -- vim.keymap.set({ 'n', 'v' }, '<space>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set({ 'n', 'v' }, '<space>a', ':CodeActionMenu<CR>', opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
        end, opts)
    end,
})

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
