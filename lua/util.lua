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

---@param obj table
M.tbl_copy = function(obj, __seen)
  if type(obj) ~= 'table' then
    return obj
  end
  if __seen and __seen[obj] then
    return __seen[obj]
  end
  local s = __seen or {}
  local res = setmetatable({}, getmetatable(obj))
  s[obj] = res
  for k, v in pairs(obj) do
    res[M.tbl_copy(k, s)] = M.tbl_copy(v, s)
  end
  return res
end

M.accept_ai_suggestion = function(fallback)
  local suggestion = require('supermaven-nvim.completion_preview')
  if suggestion.has_suggestion() then
    suggestion.on_accept_suggestion()
  elseif fallback then
    fallback()
  end
end

M.tbl_exclude = function(tbl, tbl_exclude)
  local exclude_set = {}
  for _, v in ipairs(tbl_exclude) do
    exclude_set[v] = true
  end

  local filtered_tbl = vim.tbl_filter(function(item)
    return not exclude_set[item]
  end, tbl)

  return filtered_tbl
end

return M
