-- Snippets
return {
  { 'rafamadriz/friendly-snippets' },
  {
    'L3MON4D3/LuaSnip',
    version = 'v2.3',
    dependencies = {
      -- Predefined snippets
      { 'rafamadriz/friendly-snippets' },
    },
    config = function()
      require('luasnip.loaders.from_vscode').lazy_load()
      require('luasnip.loaders.from_lua').load({ paths = { './snippets' } })

      require('luasnip').filetype_extend('typescript', { 'tsdoc' })
      require('luasnip').filetype_extend('typescriptreact', { 'tsdoc' })
      require('luasnip').filetype_extend('javascript', { 'jsdoc' })
      require('luasnip').filetype_extend('javascriptreact', { 'jsdoc' })
      require('luasnip').filetype_extend('lua', { 'luadoc' })
      require('luasnip').filetype_extend('python', { 'pydoc' })
      require('luasnip').filetype_extend('rust', { 'rustdoc' })
      require('luasnip').filetype_extend('cs', { 'csharpdoc' })
      require('luasnip').filetype_extend('java', { 'javadoc' })
      require('luasnip').filetype_extend('c', { 'cdoc' })
      require('luasnip').filetype_extend('cpp', { 'cppdoc' })
      require('luasnip').filetype_extend('php', { 'phpdoc' })
      require('luasnip').filetype_extend('kotlin', { 'kdoc' })
      require('luasnip').filetype_extend('ruby', { 'rdoc' })
      require('luasnip').filetype_extend('sh', { 'shelldoc' })
    end,
  },
}
