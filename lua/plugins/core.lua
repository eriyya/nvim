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
  -- Indent guides
  -- {
  --   'lukas-reineke/indent-blankline.nvim',
  --   main = 'ibl',
  --   config = function()
  --     require('ibl').setup({
  --       scope = {
  --         enabled = false,
  --       },
  --     })
  --   end,
  -- },
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
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
  -- List fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.3',
    priority = 100,
  },
  -- Fuzzy finder extension for telescope
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
  },
  -- Statusline
  { 'nvim-lualine/lualine.nvim' },
  -- File explorer
  -- {
  --   'nvim-tree/nvim-tree.lua',
  --   config = function()
  --     require('nvim-tree').setup({
  --       sync_root_with_cwd = true,
  --       view = {
  --         width = {},
  --       },
  --       renderer = {
  --         highlight_git = true,
  --         root_folder_modifier = ':t',
  --         icons = {
  --           glyphs = {
  --             symlink = '',
  --             bookmark = '◉',
  --             git = {
  --               unstaged = '',
  --               staged = '',
  --               unmerged = '',
  --               renamed = '',
  --               deleted = '',
  --               untracked = '',
  --               ignored = '',
  --             },
  --             folder = {
  --               default = '',
  --               open = '',
  --               symlink = '',
  --             },
  --           },
  --           show = {
  --             git = false,
  --             file = true,
  --             folder = true,
  --             folder_arrow = false,
  --           },
  --         },
  --         indent_markers = {
  --           enable = true,
  --         },
  --       },
  --     })
  --   end,
  -- },
  -- Quickly navigate between primary files
  {
    'ThePrimeagen/harpoon',
    opts = {
      save_on_toggle = true,
    },
  },
  -- Live preview markdown docs in the browser
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
  },
}
