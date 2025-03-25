-- Discord rich presence
return {
  'andweeb/presence.nvim',
  config = function()
    local presence = require('presence')
    presence.setup({
      auto_update = false,
      show_time = false,
      enable_line_number = false,
    })

    vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'BufWinEnter' }, {
      callback = function()
        presence:update()
      end,
    })
  end,
}
