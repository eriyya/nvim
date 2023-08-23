return {
  {
    'nvim-lua/plenary.nvim',
  },
  { 'tpope/vim-surround' },
  -- { 'jiangmiao/auto-pairs' },
  -- { 'Raimondi/delimitMate' },
  {
    'windwp/nvim-autopairs',
    opts = {
      fast_wrap = {},
      disable_filetype = { 'TelescopePrompt', 'vim' },
    },
    config = function(_, opts)
      require('nvim-autopairs').setup(opts)

      -- setup cmp for autopairs
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      require('cmp').event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },
  { 'nvim-lualine/lualine.nvim' },
  {
    'nvim-tree/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup({
        sync_root_with_cwd = true,
        view = {
          width = {},
        },
      })
    end,
  },
  {
    'ThePrimeagen/harpoon',
    opts = {
      save_on_toggle = true,
    },
  },
}
