local dirpath = vim.fn.stdpath('config')

local function plugin(plugin_name)
  local plugin_path = vim.fn.resolve(dirpath .. '/lua/custom/' .. plugin_name)
  return {
    dir = plugin_path,
    config = function()
      require(plugin_name).setup({})
    end,
  }
end

return {
  plugin('dotnet'),
}
