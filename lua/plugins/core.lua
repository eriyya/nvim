return {
  -- Utility functions for lua plugins
  { 'nvim-lua/plenary.nvim' },
  -- Easily change surrounding characters
  { 'tpope/vim-surround' },
  -- Auto detect tabstop and shiftwidth
  { 'tpope/vim-sleuth' },
  -- Git integration
  { 'tpope/vim-fugitive' },
  -- Undo history visualizer
  { 'mbbill/undotree' },
  -- TODO comments
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup({})
    end,
  },
  -- Auto close pairs
  {
    'windwp/nvim-autopairs',
    dependencies = { 'hrsh7th/nvim-cmp' },
    opts = {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)

      -- Setup cmp for autopairs
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  -- Statusline
  { 'nvim-lualine/lualine.nvim' },
  -- Quickly navigate between primary files
  {
    'ThePrimeagen/harpoon',
    opts = {
      save_on_toggle = true,
    },
  },
}
