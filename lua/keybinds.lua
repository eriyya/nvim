local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local util = require('util')

local key = function(mode, keys, func, desc, silent)
  silent = silent or true
  vim.keymap.set(mode, keys, func, { desc = desc, silent = silent })
end

--------------------------
------ Insert Mode -------
--------------------------

key('i', 'kj', '<Esc>', 'Leave insert mode')
key('i', 'jk', '<Esc>', 'Leave insert mode')

key('i', '<C-l>', util.accept_ai_suggestion, 'Accept AI suggestions')

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

key('n', '<C-h>', ':nohlsearch<CR>', 'Remove highlight')
key('n', '<leader>y', '"+y', 'Yank to system clipboard')
key('n', '<leader>w', ':w<CR>', 'Save file')
key('n', '<C-p>', '<cmd>Telescope find_files<CR>', 'Find files')
key('n', '<C-b>', '<cmd>Telescope buffers<CR>', 'Find buffers')

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
key('n', '<leader>do', '<cmd>Neogen<CR>', 'Generate context doc comment')
key('n', '<leader>df', '<cmd>Neogen func<CR>', 'Generate function doc comment')
key('n', '<leader>dt', '<cmd>Neogen type<CR>', 'Generate type doc comment')

-- NvimTree open
key('n', '<C-n>', ':NvimTreeToggle<CR>', 'Toggle NvimTree')

-- Fuzzy find files
key('n', '<leader>/', function()
  local telescope = require('telescope.builtin')
  local telescope_themes = require('telescope.themes')
  telescope.current_buffer_fuzzy_find(telescope_themes.get_dropdown({
    previewer = false,
  }))
end, 'Fuzzy find in current buffer')

-- Live Grep
key('n', '<leader>rg', function()
  local telescope = require('telescope.builtin')
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

-- Snacks keybinds

local snacks = require('snacks')

key('n', '<leader>lg', snacks.lazygit.open, '[Snacks] Open Lazygit')
key('n', '<leader>S', snacks.scratch.select, '[Snacks] Select Scratch Buffer')
key('n', '<leader>.', function()
  snacks.scratch()
end, '[Snacks] Toggle Scratch Buffer')
key('n', '<leader>bd', function()
  snacks.bufdelete()
end, '[Snacks] Delete Buffer')
key('n', '<leader>gb', snacks.git.blame_line, '[Snacks] Git Blame Line')
key({ 'n', 't' }, '<leader>;', function()
  snacks.terminal()
end, '[Snacks] Toggle Terminal')
key({ 'n', 't' }, ']]', function()
  snacks.words.jump(vim.v.count1)
end, '[Snacks] Next Reference')
key({ 'n', 't' }, '[[', function()
  snacks.words.jump(-vim.v.count1)
end, '[Snacks] Prev Reference')

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

-- key({ 'n', 't' }, '<leader>;', require('term').term_toggle, 'Toggle terminal split')
-- key('t', '<Esc>', [[<C-\><C-n>]], 'Exit terminal insert mode')

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

    lsp_key('n', 'gd', '<cmd>Telescope lsp_definitions<CR>', 'Goto Definitions')
    lsp_key('n', 'gr', ':Lspsaga finder ref<CR>', 'Find references')
    lsp_key('n', 'gI', '<cmd>Telescope lsp_implementations<CR>', 'Goto Implementations')
    lsp_key('n', '<leader>D', '<cmd>Telescope lsp_type_definitions<CR>', 'Goto Type Definitions')
    lsp_key('n', '<C-s>', '<cmr>Telescope lsp_document_symbols<CR>', 'Document Symbols')
    lsp_key(
      'n',
      '<leader>ws',
      '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>',
      'Workspace Symbols'
    )
    lsp_key('n', '<leader>f', format, 'Format Document')
    lsp_key('n', 'K', vim.lsp.buf.hover, 'Show hover docs')
    lsp_key('n', '<leader>rn', ':Lspsaga rename<CR>', 'Rename')
    lsp_key({ 'n', 'x' }, '<leader>a', ':Lspsaga code_action<CR>', 'Code Action')
    lsp_key({ 'i' }, '<C-k>', vim.lsp.buf.signature_help, 'Show signature help')

    lsp_key('n', '[d', function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, 'Goto prev diagnostic')
    lsp_key('n', ']d', function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, 'Goto next diagnostic')

    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    -- Toggle inlay hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      lsp_key('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }))
      end, 'Toggle Inlay Hints')
    end
  end,
})

