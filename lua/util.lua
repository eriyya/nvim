local M = {}

local os_uname = vim.loop.os_uname()

M.OS = os_uname.sysname
M.IS_WINDOWS = M.OS:find('Windows') and true or false
M.IS_UNIX = M.OS == 'Linux' or M.OS == 'Darwin'
M.IS_WSL = M.IS_UNIX and os_uname.release:find('Microsoft') and true or false

---@param mappings {n: table[], i: table[], v: table[], t: table[]}
M.set_keymaps = function(mappings)
  for mode, maps in pairs(mappings) do
    for _, map in pairs(maps) do
      local opts = map[3] or { noremap = true }

      if #mode > 1 then
        local modes = {}
        for i = 1, #mode do
          table.insert(modes, mode:sub(i, i))
        end
        mode = modes
      end

      vim.keymap.set(mode, map[1], map[2], opts)
    end
  end
end

---@param tbl table
---@param v any
M.table_contains = function(tbl, v)
  for _, val in ipairs(tbl) do
    if val == v then
      return true
    end
  end
end

---@param tbl table
---@param fn function
M.map = function(tbl, fn)
  local t = {}
  for k, v in pairs(tbl) do
    t[k] = fn(v)
  end
  return t
end

---@param str string
M.lines = function(str)
  local res = {}

  for line in str:gmatch('[^\n]+') do
    table.insert(res, line)
  end

  return res
end

return M
