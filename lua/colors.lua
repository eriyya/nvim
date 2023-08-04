vim.cmd.colorscheme 'catppuccin'

if vim.g.neovide then
    vim.g.neovide_transparency = 0.9
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_theme = 'auto'
end

require('catppuccin').setup {
    flavour = 'mocha',
    no_italic = true,
}
