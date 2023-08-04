-- Keybinds config
local keybinds = {
	i = {
		{ 'kj', '<ESC>' },
	},
	n = {
		{ 'H',          '^' },
		{ 'L',          '$' },
		{ '<C-h>',      ':nohlsearch<CR>' },
		{ '<leader>bd', ':bd<CR>' },
		-- Yank to System Clipboard
		{ '<leader>y',  '"+y' },
		{ '<leader>w',  ':w<CR>' },
		{ '<leader>b', ':NvimTreeToggle<CR>' }
	},
	v = {
		{ 'H',         '^' },
		{ 'L',         '$' },
		{ '<leader>y', '"+y' }
	},
}

-- Set the keybinds from the table
for mode, maps in pairs(keybinds) do
	for _, map in pairs(maps) do
		vim.keymap.set(mode, map[1], map[2], { noremap = true })
	end
end

-----------------------------
--  Telescope keybindings  --
-----------------------------

local telescope = require('telescope.builtin')

-- Ctrl + p to find files
vim.keymap.set('n', '<C-p>', telescope.find_files, { noremap = true })
-- Ctrl + b to find buffers
vim.keymap.set('n', '<C-b>', telescope.buffers, { noremap = true })
