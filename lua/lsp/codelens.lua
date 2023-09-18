vim.api.nvim_create_augroup('LSP_codelens', {})
vim.api.nvim_create_autocmd('LspAttach', {
  group = 'LSP_codelens',
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.client_id)

    if client and client.server_capabilities.codeLensProvider then
      local codelens = vim.api.nvim_create_augroup('LSPCodeLens', { clear = true })
      vim.api.nvim_create_autocmd({ 'BufEnter', 'InsertLeave', 'CursorHold' }, {
        group = codelens,
        callback = function()
          print("Refreshing codelens")
          vim.lsp.codelens.refresh()
        end,
        buffer = bufnr,
      })
    end
  end,
})
