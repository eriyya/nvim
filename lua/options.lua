vim.opt.timeoutlen = 300
vim.opt.updatetime = 300

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1 -- Will use the value of shiftwidth
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.wo.number = true
vim.opt.number = true
vim.opt.termguicolors = true

vim.opt.ruler = false
vim.opt.numberwidth = 2
vim.opt.mouse = 'a'
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.fillchars = { eob = ' ' }
vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.showmode = false -- hide mode since it's shown in the statusbar


vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true

vim.o.signcolumn = 'yes'
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.scrolloff = 10

vim.o.completeopt = 'menuone,noselect'

vim.g.markdown_fenced_languages = {
  'html',
  'css',
  'javascript',
  'typescript',
  'bash=sh',
  'json',
  'lua',
}

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

