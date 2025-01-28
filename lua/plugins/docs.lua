-- Documentation Generation (JSDoc etc.)
return {
  {
    'danymat/neogen',
    config = function()
      require('neogen').setup({
        enabled = true,
        snipped_engine = 'luasnip',
      })
    end,
  },
}
