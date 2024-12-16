local M = {}

-- Stolen from https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/lsp/format.lua

function M.format()
  local buf = vim.api.nvim_get_current_buf()

  local formatters = M.get_formatters(buf)
  local client_ids = vim.tbl_map(function(client)
    return client.id
  end, formatters.active)

  if #client_ids == 0 then
    return
  end

  vim.lsp.buf.format(vim.tbl_deep_extend('force', {
    bufnr = buf,
    filter = function(client)
      return vim.tbl_contains(client_ids, client.id)
    end,
  }, { async = true }))
end

function M.get_formatters(bufnr)
  local ft = vim.bo[bufnr].filetype
  -- check if we have any null-ls formatters for the current filetype
  local null_ls = package.loaded['null-ls']
      and require('null-ls.sources').get_available(ft, 'NULL_LS_FORMATTING')
    or {}

  local ret = {
    active = {},
    available = {},
    null_ls = null_ls,
  }

  ---@type vim.lsp.Client[]
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  for _, client in ipairs(clients) do
    if M.supports_format(client) then
      if (#null_ls > 0 and client.name == 'null-ls') or #null_ls == 0 then
        table.insert(ret.active, client)
      else
        table.insert(ret.available, client)
      end
    end
  end

  return ret
end

---@param client vim.lsp.Client
function M.supports_format(client)
  return client.supports_method('textDocument/formatting')
    or client.supports_method('textDocument/rangeFormatting')
end

return M
