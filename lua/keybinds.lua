local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local telescope = require('telescope.builtin')
local telescope_themes = require('telescope.themes')
local ts_actions = require('telescope.actions')
local ts_finders = require('telescope.finders')
local ts_pickers = require('telescope.pickers')
local ts_sorters = require('telescope.sorters')

local key = function(mode, keys, func, desc, silent)
  silent = silent or true
  vim.keymap.set(mode, keys, func, { desc = desc, silent = silent })
end

--------------------------
------ Insert Mode -------
--------------------------

key('i', 'kj', '<Esc>', 'Leave insert mode')
key('i', 'jk', '<Esc>', 'Leave insert mode')

-------------------------
------ Normal Mode ------
-------------------------

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

key('n', 'H', '^', 'Goto start of line')
key('n', 'L', '$', 'Goto end of line')
key('o', 'H', '^', 'Goto start of line')
key('o', 'L', '$', 'Goto end of line')

-- here is a likne
-- here is a likne
-- here is a likne

key('n', '<C-h>', ':nohlsearch<CR>', 'Remove highlight')
key('n', '<leader>y', '"+y', 'Yank to system clipboard')
key('n', '<leader>w', ':w<CR>', 'Save file')
key('n', '<C-p>', telescope.find_files, 'Find files')
key('n', '<C-b>', telescope.buffers, 'Find buffers')
-- key('n', '<A-j>', ':move .+1<CR>==', 'Move current line down')
-- key('n', '<A-k>', ':move .-2<CR>==', 'Move current line up')

-- Move lines (from LazyVim)
key('n', '<A-j>', "<cmd>execute 'move .+' . v:count1<cr>==", 'Move Down')
key('n', '<A-k>', "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", 'Move Up')
key('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', 'Move Down')
key('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', 'Move Up')
key('v', '<A-j>', ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", 'Move Down')
key('v', '<A-k>', ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", 'Move Up')

key('n', '<leader>tl', ':TodoTrouble<CR>', 'Show Trouble todo list')
key(
  'n',
  '<leader>tt',
  ':Trouble diagnostics toggle win.relative=win<CR>',
  'Show Trouble diagnostic list'
)
key('n', '<leader>ut', vim.cmd.UndotreeToggle, 'Toggle UndoTree')
key('n', '<leader>do', ':Neogen<CR>', 'Generate context doc comment')
key('n', '<leader>df', ':Neogen func<CR>', 'Generate function doc comment')
key('n', '<leader>dt', ':Neogen type<CR>', 'Generate type doc comment')

-- NeoTree open <C-n> (in file-tree.lua)

-- Fuzzy find files
key('n', '<leader>/', function()
  telescope.current_buffer_fuzzy_find(telescope_themes.get_dropdown({
    previewer = false,
  }))
end, 'Fuzzy find in current buffer')

-- Live Grep
key('n', '<leader>rg', function()
  telescope.live_grep({
    prompt_title = 'Live Grep',
  })
end, 'Live Grep')

-- Treesitter Context
key('n', '[c', function()
  require('treesitter-context').go_to_context()
end, 'Goto current treesitter context')

-- Neorg keybinds
key('n', '<leader>no', require('neorg-utils').neorg_telescope_workspaces)

--------------------------
------ Visual Mode -------
--------------------------

key('v', '<leader>f', '=', 'Vim format (when no LSP)')
key('v', 'H', '^', 'Goto start of line (VISUAL MODE)')
key('v', 'L', '$', 'Goto end of line (VISUAL MODE)')
key('v', '<leader>y', '"+y', 'Yank selection to system clipboard (VISUAL MODE)')
key('v', '<A-j>', ":move '>+1<CR>gv=gv", 'Move selection down')
key('v', '<A-k>', ":move '<-2<CR>gv=gv", 'Move selection up')
key('v', '<C-k>', '<Esc>', 'Leave visual mode')

--------------------------
------- Term Mode --------
--------------------------

key({ 'n', 't' }, '<leader>;', require('term').term_toggle, 'Toggle terminal split')
key('t', '<Esc>', [[<C-\><C-n>]], 'Exit terminal insert mode')

--------------------------
-------- Harpoon ---------
--------------------------

local harpoon = require('harpoon')

key('n', '<leader>m', function()
  harpoon.ui:toggle_quick_menu(harpoon:list())
end, '[Harpoon]: Show mark menu')
key('n', '<leader>h', function()
  harpoon:list():add()
end, '[Harpoon]: Add current file')
key('n', '<leader>J', function()
  harpoon:list():select(1)
end, '[Harpoon]: Goto mark 1')
key('n', '<leader>K', function()
  harpoon:list():select(2)
end, '[Harpoon]: Goto mark 2')
key('n', '<leader>L', function()
  harpoon:list():select(3)
end, '[Harpoon]: Goto mark 3')
key('n', '<leader>H', function()
  harpoon:list():select(4)
end, '[Harpoon]: Goto mark 4')

--------------------------
---------- LSP -----------
--------------------------

autocmd('LspAttach', {
  group = augroup('UserLspConfig', { clear = true }),
  callback = function(ev)
    -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local format = require('lsp.formatting').format

    local lsp_key = function(mode, keys, func, desc, silent)
      silent = silent or true
      vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = '[LSP]: ' .. desc })
    end

    lsp_key('n', 'gd', telescope.lsp_definitions, 'Goto Definitions')
    lsp_key('n', 'gr', ':Lspsaga finder ref<CR>', 'Find references')
    lsp_key('n', 'gI', telescope.lsp_implementations, 'Goto Implementations')
    lsp_key('n', '<leader>D', telescope.lsp_type_definitions, 'Goto Type Definitions')
    lsp_key('n', '<C-s>', telescope.lsp_document_symbols, 'Document Symbols')
    lsp_key('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols, 'Workspace Symbols')
    lsp_key('n', '<leader>f', format, 'Format Document')
    lsp_key('n', 'K', vim.lsp.buf.hover, 'Show hover docs')
    lsp_key('n', '<leader>rn', ':Lspsaga rename<CR>', 'Rename')
    lsp_key('n', '[d', vim.diagnostic.goto_prev, 'Goto previous diagnostic')
    lsp_key('n', ']d', vim.diagnostic.goto_next, 'Goto next diagnostic')
    lsp_key({ 'n', 'x' }, '<leader>a', ':Lspsaga code_action<CR>', 'Code Action')
    lsp_key({ 'i' }, '<C-k>', vim.lsp.buf.signature_help, 'Show signature help')

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Toggle inlay hints
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      lsp_key('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
      end, 'Toggle Inlay Hints')
    end
  end,
})
