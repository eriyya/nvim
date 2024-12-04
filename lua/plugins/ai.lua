function setup_supermaven()
  if not vim.settings.code_llm then
    return
  end
  require('supermaven-nvim').setup({})
  vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#6CC644' })
end

function setup_copilot()
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
end

return {
  -- {
  --   'supermaven-inc/supermaven-nvim',
  --   config = setup_supermaven,
  -- },
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   config = setup_copilot,
  -- },
}
