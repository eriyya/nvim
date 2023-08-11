vim.opt.clipboard = 'unnamedplus'

vim.opt.timeoutlen = 300
vim.opt.updatetime = 300

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = -1 -- Will use the value of shiftwidth
vim.opt.autoindent = false
vim.opt.expandtab = true
vim.opt.smartindent = true

-- UI Settings
vim.opt.number = true
vim.opt.termguicolors = true

vim.opt.ruler = false
vim.opt.numberwidth = 2
vim.opt.mouse = "a"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.fillchars = { eob = " " }

vim.opt.cursorline = true

vim.opt.signcolumn = 'yes'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
