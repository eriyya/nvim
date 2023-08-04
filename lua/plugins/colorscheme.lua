return {
    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
    {
        'xiyaowong/transparent.nvim',
        config = function() require('transparent').setup({}) end
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
