local dirpath = vim.fn.stdpath('config')

local function plugin(plugin_name, lazy_opts)
  local opts = lazy_opts or {}
  local plugin_path = vim.fn.resolve(dirpath .. '/lua/custom/' .. plugin_name)
  return vim.tbl_extend('force', opts, {
    dir = plugin_path,
    config = function()
      require(plugin_name).setup({})
    end,
  })
end

return {
  plugin('dotnet', { lazy = true, ft = { 'cs', 'fs' } }),
}
