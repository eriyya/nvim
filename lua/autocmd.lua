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
augroup('LineNumbers', { clear = true })
autocmd('InsertEnter', {
    group = 'LineNumbers',
    callback = function()
        vim.opt.relativenumber = false
    end
})
autocmd('InsertLeave', {
    group = 'LineNumbers',
    callback = function()
        vim.opt.relativenumber = true
    end
})
