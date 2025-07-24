local dirpath = vim.fn.stdpath('config')

local function plugin(plugin_name, lazy_load)
  local is_lazy = lazy_load or false
  local plugin_path = vim.fn.resolve(dirpath .. '/lua/custom/' .. plugin_name)
  return {
    dir = plugin_path,
    config = function()
      require(plugin_name).setup({})
    end,
    lazy = is_lazy,
  }
end

return {
  plugin('dotnet', true),
}
