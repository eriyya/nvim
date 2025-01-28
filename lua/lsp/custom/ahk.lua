local AHK_ENV_PATH = os.getenv('AH2_PATH')
local AHK_ENV_LSP_PATH = os.getenv('AH2_LSP_PATH')

if not AHK_ENV_LSP_PATH or not AHK_ENV_PATH then
  local ft = vim.filetype
  if ft == 'ah2' or ft == 'ahk' then
    vim.notify('Could not find ahk env vars')
  end
  return
end

local config = {
  autostart = true,
  cmd = {
    'node',
    vim.fn.expand(AHK_ENV_LSP_PATH),
    '--stdio',
  },
  filetypes = { 'ahk', 'autohotkey', 'ah2', 'ahk2' },
  init_options = {
    locale = 'en-us',
    InterpreterPath = vim.fn.expand(AHK_ENV_PATH .. '/AutoHotkey.exe'),
  },
  single_file_support = true,
  flags = { debounce_text_changes = 500 },
}

-- AHK2 lsp (needs manual installation see: `https://github.com/thqby/vscode-autohotkey2-lsp/tree/main`)
local lspconfig = require('lspconfig')
local nvim_lsp = require('lspconfig.configs')

nvim_lsp['ahk2'] = { default_config = config }
lspconfig['ahk2'].setup({})
