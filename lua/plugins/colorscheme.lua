return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 999,
    },
    {
        'rose-pine/neovim',
        name = 'rose-pine',
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
    {
        'nvim-tree/nvim-web-devicons',
        config = function()
            require('nvim-web-devicons').setup({
                default = true
            })
        end
    },
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
