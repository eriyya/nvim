local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
    group = 'YankHighlight',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350 })
    end
})

-- Absolute line numbers in insert mode and relative in normal mode
-- augroup('LineNumbers', { clear = true })
autocmd('InsertEnter', { command = ':set nu nornu' })
autocmd('InsertLeave', { command = ':set nu rnu' })

-- augroup('AutoFormat', {})
-- autocmd('BufWritePre', {
--  pattern = '*.(lua|js|jsx|ts|tsx|cs|rs)',
--  group = 'AutoFormat',
--  callback = function()
--      vim.lsp.buf.format({})
--  end
-- })
