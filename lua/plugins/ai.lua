return {
  'supermaven-inc/supermaven-nvim',
  config = function()
    if not vim.settings.code_llm then
      return
    end
    require('supermaven-nvim').setup({})
    -- vim.api.nvim_set_hl(0, 'CmpItemKindSupermaven', { fg = '#6CC644' })
  end,
}
