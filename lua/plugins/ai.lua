return {
  -- Cursor like AI integration 
  -- {
  --   ' yetone/avante.nvim',
  -- },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      if not vim.settings.code_llm then
        return
      end
      require('supermaven-nvim').setup({})
      -- vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#6CC644' })
    end,
  },
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = function()
      if not vim.settings.code_llm then
        return
      end
      require('copilot').setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            dismiss = '<C-l>',
          },
        },
      })
    end,
  },
}
