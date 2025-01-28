local banners = require('plugins.dashboard.banners')

return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local button = require('alpha.themes.dashboard').button
    local theme = require('alpha.themes.theta')

    -- Header
    theme.header.val = banners.nvim
    theme.header.type = 'text'
    theme.header.opts.hl = 'Constant'

    theme.buttons.val = {
      { type = 'text', val = 'Quick list', opts = { position = 'center' } },
      { type = 'padding', val = 1 },
      button('e', '  New file', '<cmd>ene<CR>'),
      button('ff', '󰈞  Find file', '<cmd>Telescope find_files<CR>'),
      button('q', '󰅚  Quit', '<cmd>qa<CR>'),
    }
    alpha.setup(theme.config)
    vim.cmd([[ autocmd FileType alpha setlocal nofoldenable | setlocal nonumber ]])
  end,
}
