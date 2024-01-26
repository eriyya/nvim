local theme = vim.settings.theme or 'nightfox'

if not pcall(vim.cmd.colorscheme, theme) then
  vim.cmd.colorscheme('nightfox')
end

vim.cmd([[highlight IndentBlanklineContextChar guifg=#C678DD gui=nocombine]])
vim.cmd([[highlight LspInlayHint guibg=none gui=nocombine]])
vim.cmd([[highlight TelescopeBorder guibg=none gui=nocombine]])

if vim.g.neovide then
  vim.g.neovide_transparency = 0.9
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_theme = 'auto'
end

require('lualine').setup({
  options = {
    theme = 'auto',
    section_separators = '',
    component_separators = '',
  },
})

