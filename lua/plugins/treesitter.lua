return {
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        cmd = { 'TSUpdateSync' },
        opts = {
            highlight = {
                enable = true,
                use_languagetree = true,
            },
            indent = { enable = true },
            ensure_installed = {
                'bash',
                'css',
                'c',
                'c_sharp',
                'dockerfile',
                'go',
                'html',
                'javascript',
                'json',
                'lua',
                'python',
                'rust',
                'scss',
                'lua',
                'toml',
                'tsx',
                'typescript',
                'yaml',
                'elixir'
            },
        }
    }
}
