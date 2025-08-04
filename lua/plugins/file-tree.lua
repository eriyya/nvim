vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

local function open_nvim_tree(data)
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  vim.cmd.enew()
  vim.cmd.bw(data.buf)
  vim.cmd.cd(data.file)
  require('nvim-tree.api').tree.open()
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

    vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
  end,
}

-- return {
--   'nvim-neo-tree/neo-tree.nvim',
--   version = '*',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'nvim-tree/nvim-web-devicons',
--     'MunifTanjim/nui.nvim',
--   },
--   lazy = false,
--   cmd = 'Neotree',
--   keys = {
--     { '<C-n>', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
--   },
--   config = function()
--     require('neo-tree').setup({
--       filesystem = {
--         -- hijack_netrw_behavior = 'open_current',
--         window = {
--           mappings = {
--             ['<C-n>'] = 'close_window',
--             ['o'] = 'open',
--           },
--         },
--       },
--       use_popups_for_input = true,
--       popup_border_style = 'NC',
--     })
--   end,
-- }
