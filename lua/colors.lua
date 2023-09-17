local theme = vim.settings.theme or 'nightfox'
vim.cmd('colorscheme ' .. theme)

vim.cmd([[highlight IndentBlanklineContextChar guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight LspInlayHint guibg=none]])

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
