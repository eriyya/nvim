local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local telescope = require('telescope.builtin')
local set_keymaps = require('util').set_keymaps

-- Generic Keybinds
set_keymaps({
  i = {
    { 'kj', '<ESC>' },
  },
  n = {
    { 'H', '^' },
    { 'L', '$' },
    { '<C-h>', ':nohlsearch<CR>' },
    { '<leader>bd', ':bd <bar> bp<CR>' },
    { '<leader>y', '"+y' }, -- Yank to System Clipboard
    { '<leader>w', ':w<CR>' },
    { '<C-n>', ':NvimTreeToggle<CR>' },
    { '<A-n>', ':NvimTreeFindFile<CR>' },
    { '<leader>rg', ':Telescope live_grep<CR>' },
    { '<leader>ud', vim.cmd.UndotreeToggle },
    -- Telescope Mappings --
    { '<C-p>', ':Telescope find_files<CR>' },
    { '<C-b>', telescope.buffers },
    -- Trouble --
    { '<leader>tl', ':TodoTrouble<CR>' },
    { '<C-l>', ':TroubleToggle<CR>' },
    { '<A-j>', ':move .+1<CR>==' },
    { '<A-k>', ':move .-2<CR>==' },
  },
  v = {
    { 'H', '^' },
    { 'L', '$' },
    { '<leader>y', '"+y' },
    { '<A-j>', ":move '>+1<CR>gv=gv" },
    { '<A-k>', ":move '<-2<CR>gv=gv" },
    { '<C-k>', '<ESC>' },
  },
})

local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')

set_keymaps({
  n = {
    {
      '[c',
      function()
        require('treesitter-context').go_to_context()
      end,
      { silent = true },
    },
    -- Harpoon --
    { '<leader>m', harpoon_ui.toggle_quick_menu },
    { '<C-m>', harpoon_mark.add_file },
    {
      '<leader>J',
      function()
        harpoon_ui.nav_file(1)
      end,
    },
    {
      '<leader>K',
      function()
        harpoon_ui.nav_file(2)
      end,
    },
    {
      '<leader>L',
      function()
        harpoon_ui.nav_file(3)
      end,
    },
    {
      '<leader>H',
      function()
        harpoon_ui.nav_file(4)
      end,
    },
  },
})

-- LSP Keybinds
autocmd('LspAttach', { -- Map keys after attaching to LSP
  group = augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local trouble = require('trouble')
    local opts = { buffer = ev.buf }

    local format = require('lsp.formatting').format
    local run_format = function()
      format()
    end

    -- Mappings
    set_keymaps({
      n = {
        -- Telescope
        { '<C-s>', ':Telescope lsp_document_symbols ignore_symbols=variable<CR>' },
        -- Trouble
        {
          '<space>q',
          function()
            trouble.open('quickfix')
          end,
        },
        {
          '<space>xl',
          function()
            trouble.open('loclist')
          end,
        },
        {
          '<space>xw',
          function()
            trouble.open('workspace_diagnostics')
          end,
        },
        {
          '<space>xd',
          function()
            trouble.open('document_diagnostics')
          end,
        },
        {
          '<space>xx',
          function()
            trouble.open()
          end,
        },
        {
          'gr',
          ':Lspsaga finder ref<CR>',
          -- function()
          -- trouble.open('lsp_references')
          -- end,
        },
        -- LSP
        -- { 'gr', vim.lsp.buf.references, opts },
        { '<space>e', vim.diagnostic.open_float },
        { 'gd', vim.lsp.buf.definition, opts },
        { 'gD', vim.lsp.buf.declaration, opts },
        {
          '<space>f',
          run_format,
          opts,
        },
        { 'K', vim.lsp.buf.hover, opts },
        { 'gi', vim.lsp.buf.implementation, opts },
        { '<C-k>', vim.lsp.buf.signature_help, opts },
        { '<space>D', vim.lsp.buf.type_definition, opts },
        { '<space>wa', vim.lsp.buf.add_workspace_folder, opts },
        { '<space>wr', vim.lsp.buf.remove_workspace_folder, opts },
        { '<space>rn', vim.lsp.buf.rename, opts },
        {
          '<space>wl',
          function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end,
          opts,
        },
        -- Diagnostics
        { '[d', vim.diagnostic.goto_prev },
        { ']d', vim.diagnostic.goto_next },
      },
      nv = {
        { '<space>a', ':Lspsaga code_action<CR>', opts }, -- LSP code actions
      },
    })
  end,
})
