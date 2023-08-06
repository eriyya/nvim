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
autocmd('InsertEnter', { command = ':set nu nornu' })
autocmd('InsertLeave', { command = ':set nu rnu' })

-- Disable continue comment on new line
autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  group = general,
  desc = "Disable New Line Comment",
})

