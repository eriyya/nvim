return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
    },
    {
        'xiyaowong/transparent.nvim',
        config = function()
            require('transparent').setup({
                extra_groups = {
                    'NvimTreeNormal'
                }
            })
        end
    },
    { 'nvim-tree/nvim-web-devicons' },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require('bufferline').setup({
                options = {
                    diagnostics = 'nvim_lsp',
                    indicator = {
                        style = 'underline'
                    }
                }
            })
        end
    }
}
