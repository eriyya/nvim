local telescope = require('telescope.builtin')

-- Keybinds config
local mappings = {
    i = {
        { 'kj', '<ESC>' },
    },
    n = {
        { ';',          ':' },
        { 'H',          '^' },
        { 'L',          '$' },
        { '<C-h>',      ':nohlsearch<CR>' },
        { '<leader>bd', ':bd <bar> bp<CR>' },
        { '<leader>y',  '"+y' }, -- Yank to System Clipboard
        { '<leader>w',  ':w<CR>' },
        { '<C-n>',      ':NvimTreeToggle<CR>' },
        -- Telescope Mappings --
        { '<C-p>',      telescope.find_files },
        { '<C-b>',      telescope.buffers },
        { '<A-j>',      ':move .+1<CR>==' },
        { '<A-k>',      ':move .-2<CR>==' }
    },
    v = {
        { 'H',         '^' },
        { 'L',         '$' },
        { '<leader>y', '"+y' },
        { '<A-j>',     ':move \'>+1<CR>gv=gv' },
        { '<A-k>',     ':move \'<-2<CR>gv=gv' }
    },
}

-- Set the keybinds from the table
for mode, maps in pairs(mappings) do
    for _, map in pairs(maps) do
        vim.keymap.set(mode, map[1], map[2], { noremap = true })
    end
end
