local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('General', { clear = true })

-- Highlight on yank
autocmd('TextYankPost', {
    group = augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350 })
    end
})

-- Absolute line numbers in insert mode and relative in normal mode
augroup('LineNumbers', { clear = true })
autocmd('InsertEnter', {
    group = 'LineNumbers',
    command = ':set nu nornu'
})
autocmd('InsertLeave', {
    group = 'LineNumbers',
    command = ':set nu rnu'
})

-- Disable continue comment on new line
autocmd("BufEnter", {
    callback = function()
        vim.opt.formatoptions:remove { "c", "r", "o" }
    end,
    group = 'General',
    desc = "Disable New Line Comment",
})
