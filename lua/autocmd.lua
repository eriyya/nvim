local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('General', { clear = true })

-- Highlight on yank
autocmd('TextYankPost', {
  group = augroup('YankHighlight', { clear = true }),
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 350 })
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
  callback = function()
    vim.opt.formatoptions:remove({ 'c', 'r', 'o' })
  end,
})

local ts_parsers = require('nvim-treesitter.parsers')

-- Make sure treesitter is enabled
autocmd('BufEnter', {
  group = 'General',
  pattern = '*.go,*.js,*.ts,*.tsx,*.c,*.rs,*.cpp,*.cs,*.lua',
  desc = 'Enable Treesitter',
  callback = function()
    if ts_parsers.get_parser(0) == nil then
      vim.cmd('TSUpdateSync')
    end
  end,
})

-- Special syntax highlighting for certain filetype

augroup('SpecialFileType', { clear = true })

autocmd({ 'BufRead', 'BufNewFile' }, {
  group = 'SpecialFileType',
  pattern = '*.spark,*.rpr',
  desc = 'Spark filetype',
  callback = function()
    vim.cmd('set filetype=spark')
    require('Comment.ft').set('spark', '#%s')
    vim.cmd('set syntax=spark')
  end,
})
