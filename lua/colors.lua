require('catppuccin').setup({
    no_italic = true,
})

vim.cmd.colorscheme 'catppuccin'

if vim.g.neovide then
    vim.g.neovide_transparency = 0.9
    vim.g.neovide_cursor_animation_length = 0
    vim.g.neovide_theme = 'auto'
end

require('nvim-web-devicons').setup({
    default = true,
})

require('lualine').setup({
    options = {
        theme = 'auto',
        section_separators = '',
        component_separators = '',
    }
})
