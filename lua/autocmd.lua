local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('General', { clear = true })

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 350 })
  end,
})

-- Absolute line numbers in insert mode and relative in normal mode
augroup('LineNumbers', { clear = true })
autocmd('InsertEnter', {
  group = 'LineNumbers',
  command = ':set nu nornu',
})
autocmd('InsertLeave', {
  group = 'LineNumbers',
  command = ':set nu rnu',
})

-- Disable continue comment on new line
autocmd('BufEnter', {
  group = 'General',
  desc = 'Disable New Line Comment',
  callback = function(args)
    vim.opt.formatoptions:remove('c')
    vim.opt.formatoptions:remove('r')
    vim.opt.formatoptions:remove('o')
  end,
})

local ts_parsers = require('nvim-treesitter.parsers')

-- Make sure treesitter is enabled
autocmd('BufEnter', {
  group = 'General',
  pattern = '*.sh,*.go,*.js,*.jsx,*.ts,*.tsx,*.c,*.rs,*.zig,*.cpp,*.cs,*.lua',
  desc = 'Enable Treesitter',
  callback = function()
    if ts_parsers.get_parser(0) == nil then
      vim.cmd('TSUpdateSync')
    end
  end,
})

autocmd('BufEnter', {
  group = 'Neorg',
  pattern = '*.norg',
  desc = 'Setup buffer settings for Norg files',
  callback = function()
    vim.keymap.set(
      'n',
      '<leader>t',
      '<Plug>(neorg.qol.todo-items.todo.task-cycle)',
      { buffer = true }
    )
  end,
})
