if not pcall(require, 'telescope') then
  return
end

local telescope = require('telescope')

telescope.setup({})

-- Load telescope extensions
telescope.load_extension('fzf')
