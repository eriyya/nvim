vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local function open_nvim_tree(data)
  local real_file = vim.fn.filereadable(data.file) == 1
  local directory = vim.fn.isdirectory(data.file) == 1

  if real_file or not directory then
    return
  end

  require('nvim-tree.api').tree.toggle({ focus = false, find_file = true })
end

return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  cmd = { 'NvimTreeToggle', 'NvimTreeOpen' },
  lazy = true,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup({
      update_focused_file = {
        enable = true,
      },
    })
  end,
  init = function()
    vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
  end,
}
