local banners = require('plugins.dashboard.banners')

return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local button = require('alpha.themes.dashboard').button
    local theta = require('alpha.themes.theta')

    -- Header
    theta.header.val = banners.nvim
    theta.header.type = 'text'
    theta.header.opts.hl = 'Constant'

    theta.file_icons.enabled = true
    theta.file_icons.provider = 'devicons'

    local section_mru = {
      type = 'group',
      val = {
        {
          type = 'text',
          val = 'Recent files',
          opts = {
            hl = 'SpecialComment',
            shrink_margin = false,
            position = 'center',
          },
        },
        { type = 'padding', val = 1 },
        {
          type = 'group',
          val = function()
            return { theta.mru(0, vim.fn.getcwd(), 4) }
          end,
          opts = { shrink_margin = false },
        },
      },
    }

    theta.buttons.val = {
      { type = 'text', val = 'Quick list', opts = { position = 'center' } },
      { type = 'padding', val = 1 },
      button('e', '  New file', '<cmd>ene<CR>'),
      button('ff', '󰈞  Find file', '<cmd>Telescope find_files<CR>'),
      button('no', '󰠮  Notes', '<cmd>NeorgWorkspace<CR>'),
      button('q', '󰅚  Quit', '<cmd>qa<CR>'),
    }

    alpha.setup({
      layout = {
        { type = 'padding', val = 2 },
        theta.header,
        { type = 'padding', val = 2 },
        section_mru,
        { type = 'padding', val = 2 },
        theta.buttons,
      },
      opts = {
        margin = 5,
        setup = function()
          vim.api.nvim_create_autocmd('DirChanged', {
            pattern = '*',
            group = 'alpha_temp',
            callback = function()
              require('alpha').redraw()
              vim.cmd('AlphaRemap')
            end,
          })
        end,
      },
    })
    vim.cmd([[ autocmd FileType alpha setlocal nofoldenable | setlocal nonumber ]])
  end,
}
