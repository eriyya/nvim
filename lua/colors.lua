local colorschemes = {
    {
        name = 'rose-pine',
        settings = {
            variant = 'main',
            disable_italics = true,
        }
    },
    {
        name = 'catppuccin',
        settings = {
            no_italic = true,
        }
    }
}

for _, scheme in ipairs(colorschemes) do
    require(scheme.name).setup(scheme.settings)
end

vim.cmd([[colorscheme rose-pine]])

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
