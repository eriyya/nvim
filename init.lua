if vim.fn.has('nvim-0.11.3') == 0 then
  vim.api.nvim_echo({ { 'nvim-0.11.3 or higher is required', 'ErrorMsg' } }, true, {})
  vim.fn.getchar()
  vim.cmd([[quit]])
end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out =
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

if vim.loader then
  vim.loader.enable(true)
end

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require('settings').setup()

function get_disabled_plugins()
  if require('util').IS_WINDOWS then
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

-- Load modules
require('colors')
require('options')
require('autocmd')
require('keybinds')
require('commands')
