-- Bootstrap lazy nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require('settings').setup()

function get_disabled_plugins()
  local util = require('util')
  if util.IS_WINDOWS then
    return { 'man' }
  end
  return {}
end

require('lazy').setup({
  spec = { import = 'plugins' },
  performance = {
    rtp = {
      disabled_plugins = get_disabled_plugins(),
    },
  },
})


require('plugin_config')

-- Load modules
require('colors')
require('options')
require('keybinds')
require('autocmd')
require('lsp')
require('commands')

