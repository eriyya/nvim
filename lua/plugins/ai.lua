function setup_supermaven()
  require('supermaven-nvim').setup({})
  vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#6CC644' })
end

return {
  {
    'supermaven-inc/supermaven-nvim',
    config = setup_supermaven,
  },
  -- Copilot integration written in lua
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('copilot').setup({
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         keymap = {
  --           dismiss = '<C-l>',
  --         },
  --       },
  --     })
  --   end,
  -- },
}
