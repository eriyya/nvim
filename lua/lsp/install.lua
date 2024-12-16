local M = {}

M.language_servers = {
  'lua_ls',
  'ts_ls',
  'jsonls',
  'gopls',
  'taplo',
  'cssls',
  'rust_analyzer',
  'zls',
  'clangd',
}

M.formatters = {
  'stylua',
  'prettierd',
}

M.linters = {
  'eslint_d',
}

M.mason_install = function(servers)
  local registry = require('mason-registry')
  local installed = registry.get_installed_package_names()
  local missing = {}

  for _, server in ipairs(servers) do
    if not vim.tbl_contains(installed, server) then
      table.insert(missing, server)
    end
  end

  if #missing > 0 then
    local confirm_install = vim.fn.confirm(
      'Servers not installed: ' .. table.concat(missing, ', ') .. '. Install?',
      '&yes\n&no'
    )
    if confirm_install == 1 then
      vim.cmd('MasonInstall ' .. table.concat(missing, ' '))
    end
  end
end

local get_formatters_and_linters = function()
  local combined_servers = vim.list_slice(M.formatters)
  vim.list_extend(combined_servers, M.linters)
  return combined_servers
end

M.mason_install(get_formatters_and_linters())

return M
